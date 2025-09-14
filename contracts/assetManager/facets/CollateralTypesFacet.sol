// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";
import {AssetManagerBase} from "./AssetManagerBase.sol";
import {CollateralTypes} from "../library/CollateralTypes.sol";
import {Globals} from "../library/Globals.sol";
import {SettingsUpdater} from "../library/SettingsUpdater.sol";
import {CollateralTypeInt} from "../library/data/CollateralTypeInt.sol";
import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";
import {CollateralType} from "../../userInterfaces/data/CollateralType.sol";
import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";
import {SafePct} from "../../utils/library/SafePct.sol";


contract CollateralTypesFacet is AssetManagerBase {
    using SafeCast for uint256;

    error DeprecationTimeToShort();
    error TokenNotValid();

    /**
     * Add new vault collateral type (new token type and initial collateral ratios).
     * NOTE: may not be called directly - only through asset manager controller by governance.
     */
    function addCollateralType(
        CollateralType.Data calldata _data
    )
        external
        onlyAssetManagerController
    {
        CollateralTypes.add(_data);
    }

    /**
     * Update collateral ratios for collateral type identified by `_collateralClass` and `_token`.
     * NOTE: may not be called directly - only through asset manager controller by governance.
     */
    function setCollateralRatiosForToken(
        CollateralType.Class _collateralClass,
        IERC20 _token,
        uint256 _minCollateralRatioBIPS,
        uint256 _safetyMinCollateralRatioBIPS
    )
        external
        onlyAssetManagerController
    {
        // use separate rate limit for each collateral type
        bytes32 actionKey = keccak256(abi.encode(msg.sig, _collateralClass, _token));
        // Verify this is either the first update, or enough time passed since last update
        SettingsUpdater.checkEnoughTimeSinceLastUpdate(actionKey);

        // validate
        bool ratiosValid =
            SafePct.MAX_BIPS < _minCollateralRatioBIPS &&
            _minCollateralRatioBIPS <= _safetyMinCollateralRatioBIPS;
        require(ratiosValid, CollateralTypes.InvalidCollateralRatios());

        // update
        CollateralTypeInt.Data storage token = CollateralTypes.get(_collateralClass, _token);
        token.minCollateralRatioBIPS = _minCollateralRatioBIPS.toUint32();
        token.safetyMinCollateralRatioBIPS = _safetyMinCollateralRatioBIPS.toUint32();
        emit IAssetManagerEvents.CollateralRatiosChanged(uint8(_collateralClass), address(_token),
            _minCollateralRatioBIPS, _safetyMinCollateralRatioBIPS);
    }

    /**
     * Deprecate collateral type identified by `_collateralClass` and `_token`.
     * After `_invalidationTimeSec` the collateral will become invalid and all the agents
     * that still use it as collateral will be liquidated.
     * NOTE: may not be called directly - only through asset manager controller by governance.
     */
    function deprecateCollateralType(
        CollateralType.Class _collateralClass,
        IERC20 _token,
        uint256 _invalidationTimeSec
    )
        external
        onlyAssetManagerController
    {
        AssetManagerSettings.Data storage settings = Globals.getSettings();
        CollateralTypeInt.Data storage token = CollateralTypes.get(_collateralClass, _token);

        // Either called for the first time OR previosly set _invalidationTimeSec has elapsed
        require(token.validUntil == 0 || token.validUntil > block.timestamp, TokenNotValid());
        require(_invalidationTimeSec >= settings.tokenInvalidationTimeMinSeconds, DeprecationTimeToShort());

        // update
        uint256 validUntil = block.timestamp + _invalidationTimeSec;
        token.validUntil = validUntil.toUint64();
        emit IAssetManagerEvents.CollateralTypeDeprecated(uint8(_collateralClass), address(_token), validUntil);
    }

    /**
     * Get collateral  information about a token.
     */
    function getCollateralType(
        CollateralType.Class _collateralClass,
        IERC20 _token
    )
        external view
        returns (CollateralType.Data memory)
    {
        return CollateralTypes.getInfo(_collateralClass, _token);
    }

    /**
     * Get the list of all available and deprecated tokens used for collateral.
     */
    function getCollateralTypes()
        external view
        returns (CollateralType.Data[] memory _collateralTypes)
    {
        return CollateralTypes.getAllInfos();
    }
}