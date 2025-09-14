// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";
import {AssetManagerBase} from "./AssetManagerBase.sol";
import {Globals} from "../library/Globals.sol";
import {AssetManagerState} from "../library/data/AssetManagerState.sol";
import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";
import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";


contract EmergencyPauseFacet is AssetManagerBase, IAssetManagerEvents {
    using SafeCast for uint256;

    error PausedByGovernance();

    function emergencyPause(bool _byGovernance, uint256 _duration)
        external
        onlyAssetManagerController
    {
        AssetManagerState.State storage state = AssetManagerState.get();
        // true -> Indicates Asset Manager is currently ppaised
        bool pausedAtStart = _paused();

        if (_byGovernance) {
            state.emergencyPausedUntil = (block.timestamp + _duration).toUint64();
            state.emergencyPausedByGovernance = true;
        }
        else {
            if (pausedAtStart && state.emergencyPausedByGovernance) {
                revert PausedByGovernance();
            }

            AssetManagerSettings.Data storage settings = Globals.getSettings();
            if (state.emergencyPausedUntil + settings.emergencyPauseDurationResetAfterSeconds <= block.timestamp) {
                state.emergencyPausedTotalDuration = 0;
            }
            uint256 currentPauseEndTime = Math.max(state.emergencyPausedUntil, block.timestamp);
            uint256 projectedStartTime =
                Math.min(currentPauseEndTime - state.emergencyPausedTotalDuration, block.timestamp);
            uint256 maxEndTime = projectedStartTime + settings.maxEmergencyPauseDurationSeconds;
            uint256 endTime = Math.min(block.timestamp + _duration, maxEndTime);
            state.emergencyPausedUntil = endTime.toUint64();
            state.emergencyPausedTotalDuration = (endTime - projectedStartTime).toUint64();
            state.emergencyPausedByGovernance = false;
        }
        if (_paused()) {
            emit EmergencyPauseTriggered(state.emergencyPausedUntil);
        } else if (pausedAtStart) {
            emit EmergencyPauseCanceled();
        }
    }

    function resetEmergencyPauseTotalDuration()
        external
        onlyAssetManagerController
    {
        AssetManagerState.State storage state = AssetManagerState.get();
        state.emergencyPausedTotalDuration = 0;
    }

    function emergencyPaused()
        external view
        returns (bool)
    {
        return _paused();
    }

    function emergencyPausedUntil()
        external view
        returns (uint256)
    {
        AssetManagerState.State storage state = AssetManagerState.get();
        return _paused() ? state.emergencyPausedUntil : 0;
    }

    function emergencyPauseDetails()
        external view
        returns (uint256 _pausedUntil, uint256 _totalPauseDuration, bool _pausedByGovernance)
    {
        AssetManagerState.State storage state = AssetManagerState.get();
        return (state.emergencyPausedUntil, state.emergencyPausedTotalDuration, state.emergencyPausedByGovernance);
    }

    function _paused() private view returns (bool) {
        AssetManagerState.State storage state = AssetManagerState.get();
        return state.emergencyPausedUntil > block.timestamp;
    }
}