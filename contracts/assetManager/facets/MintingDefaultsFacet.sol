// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {IReferencedPaymentNonexistence, IConfirmedBlockHeightExists}
    from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";
import {SafePct} from "../../utils/library/SafePct.sol";
import {AssetManagerBase} from "./AssetManagerBase.sol";
import {IIAgentVault} from "../../agentVault/interfaces/IIAgentVault.sol";
import {ReentrancyGuard} from "../../openzeppelin/security/ReentrancyGuard.sol";
import {Transfers} from "../../utils/library/Transfers.sol";
import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";
import {Conversion} from "../library/Conversion.sol";
import {Agents} from "../library/Agents.sol";
import {Minting} from "../library/Minting.sol";
import {TransactionAttestation} from "../library/TransactionAttestation.sol";
import {Agent} from "../library/data/Agent.sol";
import {CollateralReservation} from "../library/data/CollateralReservation.sol";
import {PaymentReference} from "../library/data/PaymentReference.sol";
import {Globals} from "../library/Globals.sol";
import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";
import {CollateralTypeInt} from "../library/data/CollateralTypeInt.sol";

contract MintingDefaultsFacet is AssetManagerBase, ReentrancyGuard {
    using Agent for Agent.State;
    using SafePct for uint256;

    error CannotUnstickMintingYet();
    error MintingNonPaymentProofWindowTooShort();
    error MintingDefaultTooEarly();
    error MintingNonPaymentMismatch();
    error SourceAddressesNotSupported();
    error NotEnoughFundsProvided();

    /**
     * When the time for minter to pay underlying amount is over (i.e. the last underlying block has passed),
     * the agent can declare payment default. Then the agent collects collateral reservation fee
     * (it goes directly to the vault), and the reserved collateral is unlocked.
     * NOTE: The attestation request must be done with `checkSourceAddresses=false`.
     * NOTE: may only be called by the owner of the agent vault in the collateral reservation request.
     * @param _proof proof that the minter didn't pay with correct payment reference on the underlying chain
     * @param _crtId id of a collateral reservation created by the minter
     */
    function mintingPaymentDefault(
        IReferencedPaymentNonexistence.Proof calldata _proof,
        uint256 _crtId
    )
        external
        nonReentrant
    {
        CollateralReservation.Data storage crt = Minting.getCollateralReservation(_crtId, true);
        require(!_proof.data.requestBody.checkSourceAddresses, SourceAddressesNotSupported());
        Agent.State storage agent = Agent.get(crt.agentVault);
        Agents.requireAgentVaultOwner(agent);
        // check requirements
        TransactionAttestation.verifyReferencedPaymentNonexistence(_proof);
        uint256 underlyingValueUBA = Conversion.convertAmgToUBA(crt.valueAMG);
        require(_proof.data.requestBody.standardPaymentReference == PaymentReference.minting(_crtId) &&
            _proof.data.requestBody.destinationAddressHash == agent.underlyingAddressHash &&
            _proof.data.requestBody.amount == underlyingValueUBA + crt.underlyingFeeUBA,
            MintingNonPaymentMismatch());

        require(_proof.data.responseBody.firstOverflowBlockNumber > crt.lastUnderlyingBlock &&
            _proof.data.responseBody.firstOverflowBlockTimestamp > crt.lastUnderlyingTimestamp,
            MintingDefaultTooEarly());

        require(_proof.data.requestBody.minimalBlockNumber <= crt.firstUnderlyingBlock,
            MintingNonPaymentProofWindowTooShort());
        // send event
        uint256 reservedValueUBA = underlyingValueUBA + Minting.calculatePoolFeeUBA(agent, crt);
        emit IAssetManagerEvents.MintingPaymentDefault(crt.agentVault, crt.minter, _crtId, reservedValueUBA);
        // calculate total fee before deleting collateral reservation
        uint256 totalFee = crt.reservationFeeNatWei + crt.executorFeeNatGWei * Conversion.GWEI;
        // release agent's reserved collateral
        Minting.releaseCollateralReservation(crt, CollateralReservation.Status.DEFAULTED);
        // share collateral reservation fee between the agent's vault and pool
        Minting.distributeCollateralReservationFee(agent, totalFee);
    }

    /**
     * If collateral reservation request exists for more than 24 hours, payment or non-payment proof are no longer
     * available. In this case agent can call this method, which burns reserved collateral at market price
     * and releases the remaining collateral (CRF is also burned).
     * NOTE: may only be called by the owner of the agent vault in the collateral reservation request.
     * NOTE: the agent (management address) receives the vault collateral (if not NAT) and NAT is burned instead.
     *      Therefore this method is `payable` and the caller must provide enough NAT to cover the received vault
     *      collateral amount multiplied by `vaultCollateralBuyForFlareFactorBIPS`.
     *      If vault collateral is NAT, it is simply burned and msg.value must be zero.
     * @param _proof proof that the attestation query window can not not contain
     *      the payment/non-payment proof anymore
     * @param _crtId collateral reservation id
     */
    function unstickMinting(
        IConfirmedBlockHeightExists.Proof calldata _proof,
        uint256 _crtId
    )
        external payable
        nonReentrant
    {
        AssetManagerSettings.Data storage settings = Globals.getSettings();
        CollateralReservation.Data storage crt = Minting.getCollateralReservation(_crtId, true);
        Agent.State storage agent = Agent.get(crt.agentVault);
        Agents.requireAgentVaultOwner(agent);

        // verify proof
        TransactionAttestation.verifyConfirmedBlockHeightExists(_proof);

        // enough time must pass so that proofs are no longer available
        require(_proof.data.responseBody.lowestQueryWindowBlockNumber > crt.lastUnderlyingBlock
            && _proof.data.responseBody.lowestQueryWindowBlockTimestamp > crt.lastUnderlyingTimestamp
            && _proof.data.responseBody.lowestQueryWindowBlockTimestamp + settings.attestationWindowSeconds <=
                _proof.data.responseBody.blockTimestamp,
            CannotUnstickMintingYet());

        // burn collateral reservation fee (guarded against reentrancy)
        Globals.getBurnAddress().transfer(crt.reservationFeeNatWei + crt.executorFeeNatGWei * Conversion.GWEI);

        // burn reserved collateral at market price
        // @audit why do we use current market price instead of price during collateral reservtion txn? Does this have any impact?
        uint256 amgToTokenWeiPrice = Conversion.currentAmgPriceInTokenWei(agent.vaultCollateralIndex);
        uint256 reservedCollateral = Conversion.convertAmgToTokenWei(crt.valueAMG, amgToTokenWeiPrice);
        uint256 burnedNatWei = _burnVaultCollateral(agent, reservedCollateral);

        // send event
        uint256 reservedValueUBA = Conversion.convertAmgToUBA(crt.valueAMG) + Minting.calculatePoolFeeUBA(agent, crt);
        emit IAssetManagerEvents.CollateralReservationDeleted(crt.agentVault, crt.minter, _crtId, reservedValueUBA);

        // release agent's reserved collateral
        Minting.releaseCollateralReservation(crt, CollateralReservation.Status.EXPIRED);
        // If there is some overpaid NAT, send it back.
        Transfers.transferNAT(payable(msg.sender), msg.value - burnedNatWei);
    }

    // We cannot burn typical vault collateral (stablecoins), so the agent must buy them for NAT
    // at FTSO price multiplied by vaultCollateralBuyForFlareFactorBIPS and then we burn the NATs.
    function _burnVaultCollateral(
        Agent.State storage _agent,
        uint256 _amountVaultCollateralWei
    )
        private
        returns (uint256 _burnedNatWei)
    {
        CollateralTypeInt.Data storage vaultCollateral = Agents.getVaultCollateral(_agent);
        CollateralTypeInt.Data storage poolCollateral = Agents.getPoolCollateral(_agent);
        AssetManagerSettings.Data storage settings = Globals.getSettings();
        IIAgentVault vault = IIAgentVault(_agent.vaultAddress());
        // Calculate NAT amount the agent has to pay to receive the "burned" vault collateral tokens.
        // The price is FTSO price plus configurable premium (vaultCollateralBuyForFlareFactorBIPS).
        _burnedNatWei = Conversion.convert(_amountVaultCollateralWei, vaultCollateral, poolCollateral)
            .mulBips(settings.vaultCollateralBuyForFlareFactorBIPS);
        // Transfer vault collateral to the agent vault owner
        vault.payout(vaultCollateral.token, Agents.getOwnerPayAddress(_agent), _amountVaultCollateralWei);
        // Burn the NAT equivalent (must be provided with the call).
        require(msg.value >= _burnedNatWei, NotEnoughFundsProvided());
        Globals.getBurnAddress().transfer(_burnedNatWei);
    }
}