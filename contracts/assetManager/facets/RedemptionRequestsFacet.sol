// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {IAddressValidity} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";
import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";
import {AssetManagerBase} from "./AssetManagerBase.sol";
import {ReentrancyGuard} from "../../openzeppelin/security/ReentrancyGuard.sol";
import {Agents} from "../library/Agents.sol";
import {AgentBacking} from "../library/AgentBacking.sol";
import {AgentPayout} from "../library/AgentPayout.sol";
import {Globals} from "../library/Globals.sol";
import {RedemptionRequests} from "../library/RedemptionRequests.sol";
import {Agent} from "../library/data/Agent.sol";
import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";
import {SafePct} from "../../utils/library/SafePct.sol";
import {AssetManagerState} from "../library/data/AssetManagerState.sol";
import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";
import {Conversion} from "../library/Conversion.sol";
import {Redemptions} from "../library/Redemptions.sol";
import {Liquidation} from "../library/Liquidation.sol";
import {TransactionAttestation} from "../library/TransactionAttestation.sol";
import {RedemptionQueue} from "../library/data/RedemptionQueue.sol";
import {Redemption} from "../library/data/Redemption.sol";


contract RedemptionRequestsFacet is AssetManagerBase, ReentrancyGuard {
    using SafePct for uint256;
    using SafeCast for uint256;
    using Agent for Agent.State;
    using RedemptionQueue for RedemptionQueue.State;

    error SelfCloseOfZero();
    error AddressValid();
    error WrongAddress();
    error InvalidRedemptionStatus();
    error RedemptionOfZero();
    error RedeemZeroLots();

    /**
     * Redeem (up to) `_lots` lots of f-assets. The corresponding amount of the f-assets belonging
     * to the redeemer will be burned and the redeemer will get paid by the agent in underlying currency
     * (or, in case of agent's payment default, by agent's collateral with a premium).
     * NOTE: in some cases not all sent f-assets can be redeemed (either there are not enough tickets or
     * more than a fixed limit of tickets should be redeemed). In this case only part of the approved assets
     * are burned and redeemed and the redeemer can execute this method again for the remaining lots.
     * In such case `RedemptionRequestIncomplete` event will be emitted, indicating the number of remaining lots.
     * Agent receives redemption request id and instructions for underlying payment in
     * RedemptionRequested event and has to pay `value - fee` and use the provided payment reference.
     * The agent can also reject the redemption request. In that case any other agent can take over the redemption.
     * If no agent takes over the redemption, the redeemer can request the default payment.
     * @param _lots number of lots to redeem
     * @param _redeemerUnderlyingAddressString the address to which the agent must transfer underlying amount
     * @param _executor the account that is allowed to execute redemption default (besides redeemer and agent)
     * @return _redeemedAmountUBA the actual redeemed amount; may be less than requested if there are not enough
     *      redemption tickets available or the maximum redemption ticket limit is reached
     */
    function redeem(
        uint256 _lots,
        string memory _redeemerUnderlyingAddressString,
        address payable _executor
    )
        external payable
        notEmergencyPaused
        nonReentrant
        returns (uint256 _redeemedAmountUBA)
    {
        uint256 maxRedeemedTickets = Globals.getSettings().maxRedeemedTickets;
        RedemptionRequests.AgentRedemptionList memory redemptionList = RedemptionRequests.AgentRedemptionList({
            length: 0,
            items: new RedemptionRequests.AgentRedemptionData[](maxRedeemedTickets)
        });

        uint256 redeemedLots = 0;
        for (uint256 i = 0; i < maxRedeemedTickets && redeemedLots < _lots; i++) {
            // redemption queue empty?
            if (AssetManagerState.get().redemptionQueue.firstTicketId == 0) {
                require(redeemedLots != 0, RedeemZeroLots());
                break;
            }
            // each loop, firstTicketId will change since we delete the first ticket
            redeemedLots += _redeemFirstTicket(_lots - redeemedLots, redemptionList);
        }

        uint256 executorFeeNatGWei = msg.value / Conversion.GWEI;

        for (uint256 i = 0; i < redemptionList.length; i++) {
            // distribute executor fee over redemption request with at most 1 gwei leftover
            uint256 currentExecutorFeeNatGWei = executorFeeNatGWei / (redemptionList.length - i);
            executorFeeNatGWei -= currentExecutorFeeNatGWei;
            RedemptionRequests.createRedemptionRequest(redemptionList.items[i], msg.sender,
                _redeemerUnderlyingAddressString, false, _executor, currentExecutorFeeNatGWei.toUint64(), 0, false);
        }

        // notify redeemer of incomplete requests
        if (redeemedLots < _lots) {
            emit IAssetManagerEvents.RedemptionRequestIncomplete(msg.sender, _lots - redeemedLots);
        }

        // burn the redeemed value of fassets
        uint256 redeemedUBA = Conversion.convertLotsToUBA(redeemedLots);
        Redemptions.burnFAssets(msg.sender, redeemedUBA);
        return redeemedUBA;
    }

    /**
     * Create a redemption from a single agent. Used in self-close exit from the collateral pool.
     * Note: only collateral pool can call this method.
     */
    function redeemFromAgent(
        address _agentVault,
        address _receiver,
        uint256 _amountUBA,
        string memory _receiverUnderlyingAddress,
        address payable _executor
    )
        external payable
        notEmergencyPaused
        nonReentrant
    {
        Agent.State storage agent = Agent.get(_agentVault);
        // Auth check: Only collateral Pool can call this function
        Agents.requireCollateralPool(agent);
        require(_amountUBA != 0, RedemptionOfZero());

        // close redemption tickets
        uint64 amountAMG = Conversion.convertUBAToAmg(_amountUBA); // divide by assetMintingGranularityUBA
        (uint64 closedAMG, uint256 closedUBA) = Redemptions.closeTickets(agent, amountAMG, false);

        // create redemption request
        RedemptionRequests.AgentRedemptionData memory redemption =
            RedemptionRequests.AgentRedemptionData(_agentVault, closedAMG);

        // AgentRedemptionData memory _data,                  redemption
        // address _redeemer,                                 _receiver
        // string memory _redeemerUnderlyingAddressString,    _receiverUnderlyingAddress
        // bool _poolSelfClose,                               true
        // address payable _executor,                         _executor
        // uint64 _executorFeeNatGWei,                        (msg.value / Conversion.GWEI).toUint64()
        // uint64 _additionalPaymentTime,                     0
        // bool _transferToCoreVault                          false

        RedemptionRequests.createRedemptionRequest(redemption, _receiver, _receiverUnderlyingAddress, true,
            _executor, (msg.value / Conversion.GWEI).toUint64(), 0, false);

        // burn the closed assets
        Redemptions.burnFAssets(msg.sender, closedUBA);
    }

    /**
     * Burn fassets from  a single agent and get paid in vault collateral(STABLECOIN) by the agent.
     * Price is FTSO price, multiplied by factor buyFAssetByAgentFactorBIPS (set by agent).
     * Used in self-close exit from the collateral pool when requested or when self-close amount is less than 1 lot.
     * Note: only collateral pool can call this method.
     */
    function redeemFromAgentInCollateral(
        address _agentVault,
        address _receiver,
        uint256 _amountUBA
    )
        external
        notEmergencyPaused
        nonReentrant
    {
        Agent.State storage agent = Agent.get(_agentVault);
        // auth check: msg.sender needs to be agent's Collateral Pool
        Agents.requireCollateralPool(agent);
        require(_amountUBA != 0, RedemptionOfZero());

        // close redemption tickets
        uint64 amountAMG = Conversion.convertUBAToAmg(_amountUBA); // divide by assetMintingGranularityUBA
        (uint64 closedAMG, uint256 closedUBA) = Redemptions.closeTickets(agent, amountAMG, true);

        // pay in collateral
        uint256 priceAmgToWei = Conversion.currentAmgPriceInTokenWei(agent.vaultCollateralIndex);
        // Applies discount, max up to 90%
        uint256 paymentWei = Conversion.convertAmgToTokenWei(closedAMG, priceAmgToWei)
            .mulBips(agent.buyFAssetByAgentFactorBIPS);
        // @audit uses Math.min(paymentWei, collateral.token.balanceOf(address(vault)));
        AgentPayout.payoutFromVault(agent, _receiver, paymentWei);

        emit IAssetManagerEvents.RedeemedInCollateral(_agentVault, _receiver, closedUBA, paymentWei);
        // burn the closed assets
        // @audit only closedUBA is burned, _amountUBA - closedUBA is still stuck in the CollateralPool.sol
        Redemptions.burnFAssets(msg.sender, closedUBA);
    }

    /**
     * To avoid unlimited work, the maximum number of redemption tickets closed in redemption, self close
     * or liquidation is limited. This means that a single redemption/self close/liquidation is limited.
     * This function calculates the maximum single redemption amount.
     */
    // @pattern returns agent.dustAMG + sum of all ticket.valueAMG
    function maxRedemptionFromAgent(
        address _agentVault
    )
        external view
        returns (uint256)
    {
        Agent.State storage agent = Agent.get(_agentVault);
        AssetManagerState.State storage state = AssetManagerState.get();

        uint64 maxRedemptionAMG = agent.dustAMG;
        uint256 maxRedeemedTickets = Globals.getSettings().maxRedeemedTickets;
        uint64 ticketId = state.redemptionQueue.agents[agent.vaultAddress()].firstTicketId;

        for (uint256 i = 0; ticketId != 0 && i < maxRedeemedTickets; i++) {
            RedemptionQueue.Ticket storage ticket = state.redemptionQueue.getTicket(ticketId);
            maxRedemptionAMG += ticket.valueAMG;
            ticketId = ticket.nextForAgent;
        }
        // multiply by assetMintingGranularityUBA
        return Conversion.convertAmgToUBA(maxRedemptionAMG);
    }

    /**
     * If the redeemer provides invalid address, the agent should provide the proof of address invalidity from the
     * Flare data connector. With this, the agent's obligations are fulfilled and they can keep the underlying.
     * NOTE: may only be called by the owner of the agent vault in the redemption request
     * NOTE: also checks that redeemer's address is normalized, so the redeemer must normalize their address,
     *   otherwise it will be rejected!
     * @param _proof proof that the address is invalid
     * @param _redemptionRequestId id of an existing redemption request
     */
    function rejectInvalidRedemption(
        IAddressValidity.Proof calldata _proof,
        uint256 _redemptionRequestId
    )
        external
        nonReentrant
    {
        Redemption.Request storage request = Redemptions.getRedemptionRequest(_redemptionRequestId, true);
        assert(!request.transferToCoreVault);   // we have a problem if core vault has invalid address
        Agent.State storage agent = Agent.get(request.agentVault);

        // check status
        require(request.status == Redemption.Status.ACTIVE, InvalidRedemptionStatus());

        // only owner can call
        Agents.requireAgentVaultOwner(agent);

        // check proof
        TransactionAttestation.verifyAddressValidity(_proof);

        // the actual redeemer's address must be validated
        bytes32 addressHash = keccak256(bytes(_proof.data.requestBody.addressStr));
        require(addressHash == request.redeemerUnderlyingAddressHash, WrongAddress());

        // and the address must be invalid or not normalized
        bool valid = _proof.data.responseBody.isValid &&
            _proof.data.responseBody.standardAddressHash == request.redeemerUnderlyingAddressHash;
        require(!valid, AddressValid());

        // release agent collateral
        AgentBacking.endRedeemingAssets(agent, request.valueAMG, request.poolSelfClose);

        // burn the executor fee
        Redemptions.burnExecutorFee(request);

        // emit event
        uint256 valueUBA = Conversion.convertAmgToUBA(request.valueAMG);
        emit IAssetManagerEvents.RedemptionRejected(request.agentVault, request.redeemer,
            _redemptionRequestId, valueUBA);

        // finish redemption request at end
        Redemptions.finishRedemptionRequest(_redemptionRequestId, request, Redemption.Status.REJECTED);
    }

    /**
     * Agent can "redeem against himself" by calling selfClose, which burns agent's own f-assets
     * and unlocks agent's collateral. The underlying funds backing the f-assets are released
     * as agent's free underlying funds and can be later withdrawn after announcement.
     * NOTE: may only be called by the agent vault owner.
     * @param _agentVault agent vault address
     * @param _amountUBA amount of f-assets to self-close
     * @return _closedAmountUBA the actual self-closed amount, may be less than requested if there are not enough
     *      redemption tickets available or the maximum redemption ticket limit is reached
     */
    function selfClose(
        address _agentVault,
        uint256 _amountUBA
    )
        external
        notEmergencyPaused
        nonReentrant
        onlyAgentVaultOwner(_agentVault)
        returns (uint256 _closedAmountUBA)
    {
        Agent.State storage agent = Agent.get(_agentVault);
        require(_amountUBA != 0, SelfCloseOfZero());
        uint64 amountAMG = Conversion.convertUBAToAmg(_amountUBA);
        (, uint256 closedUBA) = Redemptions.closeTickets(agent, amountAMG, true);
        // burn the self-closed assets
        Redemptions.burnFAssets(msg.sender, closedUBA);
        // try to pull agent out of liquidation
        Liquidation.endLiquidationIfHealthy(agent);
        // send event
        emit IAssetManagerEvents.SelfClose(_agentVault, closedUBA);
        return closedUBA;
    }

    /**
     * After a lot size change by the governance, it may happen that after a redemption
     * there remains less than one lot on a redemption ticket. This is named "dust" and
     * can be self closed or liquidated, but not redeemed. However, after several such redemptions,
     * the total dust can amount to more than one lot. Using this method, the amount, rounded down
     * to a whole number of lots, can be converted to a new redemption ticket.
     * NOTE: we do NOT check that the caller is the agent vault owner, since we want to
     * allow anyone to convert dust to tickets to increase asset fungibility.
     * @param _agentVault agent vault address
     */
    function convertDustToTicket(
        address _agentVault
    )
        external
        nonReentrant
    {
        AssetManagerSettings.Data storage settings = Globals.getSettings();
        Agent.State storage agent = Agent.get(_agentVault);

        // if dust is more than 1 lot, create a new redemption ticket
        if (agent.dustAMG >= settings.lotSizeAMG) {
            uint64 remainingDustAMG = agent.dustAMG % settings.lotSizeAMG;
            uint64 ticketValueAMG = agent.dustAMG - remainingDustAMG;
            AgentBacking.createRedemptionTicket(agent, ticketValueAMG);
            AgentBacking.changeDust(agent, remainingDustAMG);
        }
    }

    function _redeemFirstTicket(
        uint256 _lots,
        RedemptionRequests.AgentRedemptionList memory _list
    )
        private
        returns (uint256 _redeemedLots)
    {
        AssetManagerState.State storage state = AssetManagerState.get();
        AssetManagerSettings.Data storage settings = Globals.getSettings();
        uint64 ticketId = state.redemptionQueue.firstTicketId;
        if (ticketId == 0) {
            return 0;    // empty redemption queue
        }

        RedemptionQueue.Ticket storage ticket = state.redemptionQueue.getTicket(ticketId);
        address agentVault = ticket.agentVault;
        Agent.State storage agent = Agent.get(agentVault);
        uint256 maxRedeemLots = (ticket.valueAMG + agent.dustAMG) / settings.lotSizeAMG;
        _redeemedLots = Math.min(_lots, maxRedeemLots);

        if (_redeemedLots > 0) {
            uint64 redeemedAMG = Conversion.convertLotsToAMG(_redeemedLots);
            // find list index for ticket's agent
            uint256 index = 0;
            while (index < _list.length && _list.items[index].agentVault != agentVault) {
                ++index;
            }

            // add to list item or create new item
            if (index < _list.length) {
                _list.items[index].valueAMG = _list.items[index].valueAMG + redeemedAMG;
            }

            else {
                _list.items[_list.length++] = RedemptionRequests.AgentRedemptionData({
                    agentVault: agentVault,
                    valueAMG: redeemedAMG
                });
            }
            // _removeFromTicket may delete ticket data, so we call it at end
            Redemptions.removeFromTicket(ticketId, redeemedAMG);
        }

        else {
            // this will just convert ticket to dust
            Redemptions.removeFromTicket(ticketId, 0);
        }
    }
}