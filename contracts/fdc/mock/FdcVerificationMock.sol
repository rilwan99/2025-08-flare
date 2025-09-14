// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import { MerkleProof } from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import {IFdcVerification, IPayment, IBalanceDecreasingTransaction, IReferencedPaymentNonexistence,
        IConfirmedBlockHeightExists, IAddressValidity, IEVMTransaction, IWeb2Json}
    from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";
import {IRelay} from "@flarenetwork/flare-periphery-contracts/flare/IRelay.sol";


contract FdcVerificationMock is IFdcVerification {
    using MerkleProof for bytes32[];

    IRelay public immutable relay;
    uint8 public immutable fdcProtocolId;

    constructor(IRelay _relay, uint8 _fdcProtocolId) {
        relay = _relay;
        fdcProtocolId = _fdcProtocolId;
    }

    function verifyPayment(
        IPayment.Proof calldata _proof
    )
        external view
        returns (bool _proved)
    {
        return _proof.data.attestationType == bytes32("Payment") &&
            _proof.merkleProof.verifyCalldata(
                relay.merkleRoots(fdcProtocolId, _proof.data.votingRound), // root
                keccak256(abi.encode(_proof.data)) // leaf
            );
    }

    function verifyBalanceDecreasingTransaction(
        IBalanceDecreasingTransaction.Proof calldata _proof
    )
        external view
        returns (bool _proved)
    {
        return _proof.data.attestationType == bytes32("BalanceDecreasingTransaction") &&
            _proof.merkleProof.verifyCalldata(
                relay.merkleRoots(fdcProtocolId, _proof.data.votingRound),
                keccak256(abi.encode(_proof.data))
            );
    }

    function verifyReferencedPaymentNonexistence(
        IReferencedPaymentNonexistence.Proof calldata _proof
    )
        external view
        returns (bool _proved)
    {
        return _proof.data.attestationType == bytes32("ReferencedPaymentNonexistence") &&
            _proof.merkleProof.verifyCalldata(
                relay.merkleRoots(fdcProtocolId, _proof.data.votingRound),
                keccak256(abi.encode(_proof.data))
            );
    }

    function verifyConfirmedBlockHeightExists(
        IConfirmedBlockHeightExists.Proof calldata _proof
    )
        external view
        returns (bool _proved)
    {
        return _proof.data.attestationType == bytes32("ConfirmedBlockHeightExists") &&
            _proof.merkleProof.verifyCalldata(
                relay.merkleRoots(fdcProtocolId, _proof.data.votingRound),
                keccak256(abi.encode(_proof.data))
            );
    }

    function verifyAddressValidity(
        IAddressValidity.Proof calldata _proof
    )
        external view
        returns (bool _proved)
    {
        return _proof.data.attestationType == bytes32("AddressValidity") &&
            _proof.merkleProof.verifyCalldata(
                relay.merkleRoots(fdcProtocolId, _proof.data.votingRound),
                keccak256(abi.encode(_proof.data))
            );
    }

    function verifyEVMTransaction(
        IEVMTransaction.Proof calldata _proof
    )
        external view
        returns (bool _proved)
    {
        return _proof.data.attestationType == bytes32("EVMTransaction") &&
            _proof.merkleProof.verifyCalldata(
                relay.merkleRoots(fdcProtocolId, _proof.data.votingRound),
                keccak256(abi.encode(_proof.data))
            );
    }

    function verifyJsonApi(
        IWeb2Json.Proof calldata _proof
    )
        external view
        returns (bool _proved)
    {
        return _proof.data.attestationType == bytes32("Web2Json") &&
            _proof.merkleProof.verifyCalldata(
                relay.merkleRoots(fdcProtocolId, _proof.data.votingRound),
                keccak256(abi.encode(_proof.data))
            );
    }
}
