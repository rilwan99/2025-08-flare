# Report


## Gas Optimizations


| |Issue|Instances|
|-|:-|:-:|
| [GAS-1](#GAS-1) | `a = a + b` is more gas effective than `a += b` for state variables (excluding arrays and mappings) | 35 |
| [GAS-2](#GAS-2) | Comparing to a Boolean constant | 1 |
| [GAS-3](#GAS-3) | Using bools for storage incurs overhead | 15 |
| [GAS-4](#GAS-4) | Cache array length outside of loop | 31 |
| [GAS-5](#GAS-5) | For Operations that will not overflow, you could use unchecked | 1361 |
| [GAS-6](#GAS-6) | Use Custom Errors instead of Revert Strings to save Gas | 1 |
| [GAS-7](#GAS-7) | Avoid contract existence checks by using low level calls | 19 |
| [GAS-8](#GAS-8) | Functions guaranteed to revert when called by normal users can be marked `payable` | 12 |
| [GAS-9](#GAS-9) | `++i` costs less gas compared to `i++` or `i += 1` (same for `--i` vs `i--` or `i -= 1`) | 88 |
| [GAS-10](#GAS-10) | Using `private` rather than `public` for constants, saves gas | 3 |
| [GAS-11](#GAS-11) | Use shift right/left instead of division/multiplication if possible | 38 |
| [GAS-12](#GAS-12) | Splitting require() statements that use && saves gas | 3 |
| [GAS-13](#GAS-13) | Superfluous event fields | 3 |
| [GAS-14](#GAS-14) | Increments/decrements can be unchecked in for-loops | 58 |
| [GAS-15](#GAS-15) | Use != 0 instead of > 0 for unsigned integer comparison | 121 |
### <a name="GAS-1"></a>[GAS-1] `a = a + b` is more gas effective than `a += b` for state variables (excluding arrays and mappings)
This saves **16 gas per instance.**

*Instances (35)*:
```solidity
File: ./contracts/assetManager/facets/ChallengesFacet.sol

176:                 total += pmi.data.responseBody.spentAmount - SafeCast.toInt256(redemptionValue);

179:                 total += pmi.data.responseBody.spentAmount;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/ChallengesFacet.sol)

```solidity
File: ./contracts/assetManager/facets/CollateralReservationsFacet.sol

88:         state.newCrtId += PaymentReference.randomizedIdSkip();

147:         _agent.reservedAMG += _reservationAMG;

148:         state.totalReservedCollateralAMG += _reservationAMG;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/CollateralReservationsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/CoreVaultClientFacet.sol

143:         state.newTransferFromCoreVaultId += PaymentReference.randomizedIdSkip();

150:         agent.reservedAMG += amountAMG;

257:         state.newRedemptionFromCoreVaultId += PaymentReference.randomizedIdSkip();

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/CoreVaultClientFacet.sol)

```solidity
File: ./contracts/assetManager/facets/RedemptionRequestsFacet.sol

81:             redeemedLots += _redeemFirstTicket(_lots - redeemedLots, redemptionList);

180:             maxRedemptionAMG += ticket.valueAMG;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/RedemptionRequestsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/UnderlyingBalanceFacet.sol

86:         state.newPaymentAnnouncementId += PaymentReference.randomizedIdSkip();

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/UnderlyingBalanceFacet.sol)

```solidity
File: ./contracts/assetManager/library/AgentBacking.sol

33:         _agent.redeemingAMG += _valueAMG;

35:             _agent.poolRedeemingAMG += _valueAMG;

60:         _agent.mintedAMG += _valueAMG;

88:             lastTicket.valueAMG += _ticketValueAMG;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/AgentBacking.sol)

```solidity
File: ./contracts/assetManager/library/Redemptions.sol

46:             _closedAMG += ticketRedeemAMG;

51:             _closedAMG += closeDustAMG;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Redemptions.sol)

```solidity
File: ./contracts/assetManager/library/UnderlyingBalance.sol

43:         _agent.underlyingBalanceUBA += _balanceIncrease.toInt256().toInt128();

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/UnderlyingBalance.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPool.sol

618:         totalFAssetFees += _amount;

626:         _fAssetFeeDebtOf[_account] += fAssets;

627:         totalFAssetFeeDebt += fAssets;

649:             totalFAssetFees += _amount;

698:             totalCollateral += msg.value;

835:         totalCollateral += claimed;

854:         totalCollateral += claimed;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPool.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPoolToken.sol

180:                 _timelocked += timelock.amount;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPoolToken.sol)

```solidity
File: ./contracts/coreVaultManager/implementation/CoreVaultManager.sol

165:             availableFunds += receivedAmount;

197:             cancelableTransferRequestsAmount += _amount;

206:                     req.amount += _amount;

212:             nonCancelableTransferRequestsAmount += _amount;

367:                 amountTmp += escrowAmountTmp;

388:                 escrowEndTimestamp += 1 days;

832:                 availableFundsTmp += amount;

875:         escrowEndTimestamp += 1 days;

879:             escrowEndTimestamp += 1 days;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/coreVaultManager/implementation/CoreVaultManager.sol)

### <a name="GAS-2"></a>[GAS-2] Comparing to a Boolean constant
Comparing to a constant (`true` or `false`) is a bit more expensive than directly checking the returned boolean value.

Consider using `if(directValue)` instead of `if(directValue == true)` and `if(!directValue)` instead of `if(directValue == false)`

*Instances (1)*:
```solidity
File: ./contracts/governance/implementation/GovernedBase.sol

106:         require(state.initialised == false, GovernedAlreadyInitialized());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/governance/implementation/GovernedBase.sol)

### <a name="GAS-3"></a>[GAS-3] Using bools for storage incurs overhead
Use uint256(1) and uint256(2) for true/false to avoid a Gwarmaccess (100 gas), and to avoid Gsset (20000 gas) when changing from ‘false’ to ‘true’, after having been ‘true’ in the past. See [source](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/58f635312aa21f947cae5f8578638a85aa2519f5/contracts/security/ReentrancyGuard.sol#L23-L27).

*Instances (15)*:
```solidity
File: ./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistry.sol

23:     mapping(address => bool) private whitelist;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistry.sol)

```solidity
File: ./contracts/agentVault/implementation/AgentVault.sol

20:     bool private initialized;

24:     bool private __internalWithdrawal; // only storage placeholder

26:     bool private destroyed;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentVault/implementation/AgentVault.sol)

```solidity
File: ./contracts/assetManager/library/data/AssetManagerState.sol

22:         mapping(string => bool) reservedPoolTokenSuffixes;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/AssetManagerState.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPool.sol

52:     bool private internalWithdrawal;

53:     bool private initialized;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPool.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPoolToken.sol

42:     bool private ignoreTimelocked;

43:     bool private initialized;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPoolToken.sol)

```solidity
File: ./contracts/coreVaultManager/implementation/CoreVaultManager.sol

45:     mapping(bytes32 transactionId => bool) public confirmedPayments;

98:     bool public paused;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/coreVaultManager/implementation/CoreVaultManager.sol)

```solidity
File: ./contracts/diamond/library/LibDiamond.sol

43:         mapping(bytes4 => bool) supportedInterfaces;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/diamond/library/LibDiamond.sol)

```solidity
File: ./contracts/fassetToken/implementation/FAsset.sol

63:     bool private _initialized;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/implementation/FAsset.sol)

```solidity
File: ./contracts/ftso/implementation/FtsoV2PriceStore.sol

80:     mapping(address trustedProvider => bool isTrustedProvider) internal trustedProvidersMap;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/ftso/implementation/FtsoV2PriceStore.sol)

```solidity
File: ./contracts/userInterfaces/data/AgentInfo.sol

40:         bool publiclyAvailable;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/AgentInfo.sol)

### <a name="GAS-4"></a>[GAS-4] Cache array length outside of loop
If not cached, the solidity compiler will always read the length of the array during each iteration. That is, if it is a storage array, this is an extra sload operation (100 additional extra gas for each iteration except for the first) and if it is a memory array, this is an extra mload operation (3 additional gas for each iteration except for the first).

*Instances (31)*:
```solidity
File: ./contracts/assetManager/facets/AgentVaultManagementFacet.sol

225:         for (uint256 i = 0; i < _agents.length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentVaultManagementFacet.sol)

```solidity
File: ./contracts/assetManager/facets/ChallengesFacet.sol

155:         for (uint256 i = 0; i < _payments.length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/ChallengesFacet.sol)

```solidity
File: ./contracts/assetManager/facets/RedemptionRequestsFacet.sol

84:         for (uint256 i = 0; i < redemptionList.length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/RedemptionRequestsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/SettingsManagementFacet.sol

568:         for (uint256 i = 0; i < _liquidationFactors.length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/SettingsManagementFacet.sol)

```solidity
File: ./contracts/assetManager/library/CollateralTypes.sol

38:         for (uint256 i = 1; i < _data.length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/CollateralTypes.sol)

```solidity
File: ./contracts/assetManager/library/SettingsValidators.sol

38:         for (uint256 i = 0; i < liquidationFactors.length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/SettingsValidators.sol)

```solidity
File: ./contracts/assetManagerController/implementation/AssetManagerController.sol

715:         for (uint256 i = 0; i < _assetManagers.length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManagerController/implementation/AssetManagerController.sol)

```solidity
File: ./contracts/coreVaultManager/implementation/CoreVaultManager.sol

193:             for (uint256 i = 0; i < cancelableTransferRequests.length; i++) {

410:         for (uint256 i = 0; i < _allowedDestinationAddresses.length; i++) {

432:         for (uint256 i = 0; i < _allowedDestinationAddresses.length; i++) {

460:         for (uint256 i = 0; i < _triggeringAccounts.length; i++) {

478:         for (uint256 i = 0; i < _triggeringAccounts.length; i++) {

538:         for (uint256 i = 0; i < _preimageHashes.length; i++) {

578:         for (uint256 i = 0; i < _preimageHashes.length; i++) {

603:         for (uint256 i = 0; i < _addresses.length; i++) {

619:         for (uint256 i = 0; i < _addresses.length; i++) {

757:         for (uint256 i = 0; i < cancelableTransferRequests.length; i++) {

767:         for (uint256 i = 0; i < nonCancelableTransferRequests.length; i++) {

868:         for (uint256 i = escrows.length; i > nextUnprocessedEscrowIndex; i--) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/coreVaultManager/implementation/CoreVaultManager.sol)

```solidity
File: ./contracts/diamond/library/LibDiamond.sol

61:         for (uint256 facetIndex; facetIndex < _diamondCut.length; facetIndex++) {

89:         for (uint256 selectorIndex; selectorIndex < _functionSelectors.length; selectorIndex++) {

108:         for (uint256 selectorIndex; selectorIndex < _functionSelectors.length; selectorIndex++) {

132:         for (uint256 selectorIndex; selectorIndex < _functionSelectors.length; selectorIndex++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/diamond/library/LibDiamond.sol)

```solidity
File: ./contracts/flareSmartContracts/implementation/AddressUpdatable.sol

72:         for (uint256 i = 0; i < _nameHashes.length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/flareSmartContracts/implementation/AddressUpdatable.sol)

```solidity
File: ./contracts/ftso/implementation/FtsoV2PriceStore.sol

126:         for (uint256 i = 0; i < _proofs.length; i++) {

188:         for (uint256 i = 0; i < _feeds.length; i++) {

218:         for (uint256 i = 0; i < _feedIds.length; i++) {

251:         for (uint256 i = 0; i < trustedProviders.length; i++) {

256:         for (uint256 i = 0; i < _trustedProviders.length; i++) {

322:         for (uint256 i = 0; i < _feedIds.length; i++) {

332:         for (uint256 i = 0; i < feedIds.length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/ftso/implementation/FtsoV2PriceStore.sol)

### <a name="GAS-5"></a>[GAS-5] For Operations that will not overflow, you could use unchecked

*Instances (1361)*:
```solidity
File: ./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistry.sol

4: import {IAgentOwnerRegistry} from "../../userInterfaces/IAgentOwnerRegistry.sol";

5: import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";

6: import {GovernedUUPSProxyImplementation} from "../../governance/implementation/GovernedUUPSProxyImplementation.sol";

7: import {IGovernanceSettings} from "@flarenetwork/flare-periphery-contracts/flare/IGovernanceSettings.sol";

39:         initialise(_governanceSettings, _initialGovernance);    // also marks as initialized

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistry.sol)

```solidity
File: ./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistryProxy.sol

4: import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

5: import {IGovernanceSettings} from "@flarenetwork/flare-periphery-contracts/flare/IGovernanceSettings.sol";

6: import {AgentOwnerRegistry} from "./AgentOwnerRegistry.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistryProxy.sol)

```solidity
File: ./contracts/agentVault/implementation/AgentVault.sol

4: import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

5: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

6: import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";

7: import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

8: import {ReentrancyGuard} from "../../openzeppelin/security/ReentrancyGuard.sol";

9: import {IIAgentVault} from "../../agentVault/interfaces/IIAgentVault.sol";

10: import {IAgentVault} from "../../userInterfaces/IAgentVault.sol";

11: import {IIAssetManager} from "../../assetManager/interfaces/IIAssetManager.sol";

12: import {ICollateralPool} from "../../userInterfaces/ICollateralPool.sol";

18:     IIAssetManager public assetManager; // practically immutable

22:     IERC20[] private __usedTokens; // only storage placeholder

23:     mapping(IERC20 => uint256) private __tokenUseFlags; // only storage placeholder

24:     bool private __internalWithdrawal; // only storage placeholder

185:     function _authorizeUpgrade(address /* _newImplementation */)

188:     { // solhint-disable-line no-empty-blocks

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentVault/implementation/AgentVault.sol)

```solidity
File: ./contracts/agentVault/implementation/AgentVaultFactory.sol

4: import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";

5: import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

6: import {IIAgentVaultFactory} from "../interfaces/IIAgentVaultFactory.sol";

7: import {AgentVault} from "./AgentVault.sol";

8: import {IIAssetManager} from "../../assetManager/interfaces/IIAssetManager.sol";

9: import {IIAgentVault} from "../../agentVault/interfaces/IIAgentVault.sol";

34:         address /* _proxy */

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentVault/implementation/AgentVaultFactory.sol)

```solidity
File: ./contracts/assetManager/facets/AgentAlwaysAllowedMintersFacet.sol

4: import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

5: import {AssetManagerBase} from "./AssetManagerBase.sol";

6: import {Agent} from "../../assetManager/library/data/Agent.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentAlwaysAllowedMintersFacet.sol)

```solidity
File: ./contracts/assetManager/facets/AgentCollateralFacet.sol

4: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

5: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

6: import {ReentrancyGuard} from "../../openzeppelin/security/ReentrancyGuard.sol";

7: import {AssetManagerBase} from "./AssetManagerBase.sol";

8: import {AgentCollateral} from "../library/AgentCollateral.sol";

9: import {Globals} from "../library/Globals.sol";

10: import {Liquidation} from "../library/Liquidation.sol";

11: import {Agents} from "../library/Agents.sol";

12: import {AgentUpdates} from "../library/AgentUpdates.sol";

13: import {Agent} from "../library/data/Agent.sol";

14: import {AssetManagerState} from "../library/data/AssetManagerState.sol";

15: import {Collateral} from "../library/data/Collateral.sol";

16: import {CollateralTypeInt} from "../library/data/CollateralTypeInt.sol";

17: import {IWNat} from "../../flareSmartContracts/interfaces/IWNat.sol";

18: import {SafePct} from "../../utils/library/SafePct.sol";

19: import {CollateralType} from "../../userInterfaces/data/CollateralType.sol";

20: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

21: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

102:             return;     // we don't care about other token withdrawals from agent vault

114:         require(block.timestamp <= withdrawal.allowedAt + settings.agentTimelockedOperationWindowSeconds,

122:         uint256 remaining = withdrawal.amountWei - _amountWei;    // guarded by above require

219:             uint256 increase = _amountWei - withdrawal.amountWei;

221:             withdrawal.allowedAt = (block.timestamp + settings.withdrawalWaitMinSeconds).toUint64();

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentCollateralFacet.sol)

```solidity
File: ./contracts/assetManager/facets/AgentInfoFacet.sol

4: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

5: import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

6: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

7: import {AssetManagerBase} from "./AssetManagerBase.sol";

8: import {AgentCollateral} from "../library/AgentCollateral.sol";

9: import {Agents} from "../library/Agents.sol";

10: import {Conversion} from "../library/Conversion.sol";

11: import {Liquidation} from "../library/Liquidation.sol";

12: import {LiquidationPaymentStrategy} from "../library/LiquidationPaymentStrategy.sol";

13: import {UnderlyingBalance} from "../library/UnderlyingBalance.sol";

14: import {Agent} from "../library/data/Agent.sol";

15: import {AssetManagerState} from "../library/data/AssetManagerState.sol";

16: import {Collateral} from "../library/data/Collateral.sol";

17: import {CollateralTypeInt} from "../library/data/CollateralTypeInt.sol";

18: import {IICollateralPool} from "../../collateralPool/interfaces/IICollateralPool.sol";

19: import {AgentInfo} from "../../userInterfaces/data/AgentInfo.sol";

113:             _info.underlyingBalanceUBA - _info.requiredUnderlyingBalanceUBA.toInt256();

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentInfoFacet.sol)

```solidity
File: ./contracts/assetManager/facets/AgentPingFacet.sol

4: import {IAgentPing} from "../../userInterfaces/IAgentPing.sol";

5: import {AssetManagerBase} from "./AssetManagerBase.sol";

6: import {Agent} from "../../assetManager/library/data/Agent.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentPingFacet.sol)

```solidity
File: ./contracts/assetManager/facets/AgentSettingsFacet.sol

4: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

5: import {AssetManagerBase} from "./AssetManagerBase.sol";

6: import {AgentUpdates} from "../library/AgentUpdates.sol";

7: import {Agent} from "../library/data/Agent.sol";

8: import {Globals} from "../library/Globals.sol";

9: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

10: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

46:         _updateAllowedAt = block.timestamp + _getTimelock(hash);

72:         require(update.validAt + settings.agentTimelockedOperationWindowSeconds >= block.timestamp,

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentSettingsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/AgentVaultAndPoolSupportFacet.sol

4: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

5: import {AssetManagerBase} from "./AssetManagerBase.sol";

6: import {Agents} from "../library/Agents.sol";

7: import {Conversion} from "../library/Conversion.sol";

8: import {Globals} from "../library/Globals.sol";

9: import {Agent} from "../library/data/Agent.sol";

10: import {IWNat} from "../../flareSmartContracts/interfaces/IWNat.sol";

11: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

12: import {CollateralType} from "../../userInterfaces/data/CollateralType.sol";

13: import {CollateralTypes} from "../library/CollateralTypes.sol";

28:         _divisor = Conversion.AMG_TOKEN_WEI_PRICE_SCALE * settings.assetMintingGranularityUBA;

59:         return Conversion.convertAmgToUBA(agent.reservedAMG + agent.mintedAMG + agent.poolRedeemingAMG);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentVaultAndPoolSupportFacet.sol)

```solidity
File: ./contracts/assetManager/facets/AgentVaultManagementFacet.sol

4: import {IAddressValidity} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

5: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

6: import {AssetManagerBase} from "./AssetManagerBase.sol";

7: import {Agents} from "../library/Agents.sol";

8: import {AgentUpdates} from "../library/AgentUpdates.sol";

9: import {Globals} from "../library/Globals.sol";

10: import {TransactionAttestation} from "../library/TransactionAttestation.sol";

11: import {Agent} from "../library/data/Agent.sol";

12: import {AssetManagerState} from "../library/data/AssetManagerState.sol";

13: import {UnderlyingAddressOwnership} from "../library/data/UnderlyingAddressOwnership.sol";

14: import {CoreVaultClient} from "../library/CoreVaultClient.sol";

15: import {IIAgentVault} from "../../agentVault/interfaces/IIAgentVault.sol";

16: import {IIAgentVaultFactory} from "../../agentVault/interfaces/IIAgentVaultFactory.sol";

17: import {IIAssetManager} from "../../assetManager/interfaces/IIAssetManager.sol";

18: import {IICollateralPool} from "../../collateralPool/interfaces/IICollateralPool.sol";

19: import {IICollateralPoolFactory} from "../../collateralPool/interfaces/IICollateralPoolFactory.sol";

20: import {IICollateralPoolTokenFactory} from "../../collateralPool/interfaces/IICollateralPoolTokenFactory.sol";

21: import {IUpgradableContractFactory} from "../../utils/interfaces/IUpgradableContractFactory.sol";

22: import {IUpgradableProxy} from "../../utils/interfaces/IUpgradableProxy.sol";

23: import {AgentSettings} from "../../userInterfaces/data/AgentSettings.sol";

24: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

25: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

26: import {ICollateralPool} from "../../userInterfaces/ICollateralPool.sol";

27: import {ICollateralPoolToken} from "../../userInterfaces/ICollateralPoolToken.sol";

83:         assert(agent.status == Agent.Status.EMPTY);     // state should be empty on creation

138:             uint256 destroyAllowedAt = block.timestamp + settings.withdrawalWaitMinSeconds;

177:         if (ind + 1 < state.allAgents.length) {

178:             state.allAgents[ind] = state.allAgents[state.allAgents.length - 1];

225:         for (uint256 i = 0; i < _agents.length; i++) {

294:         for (uint256 i = 0; i < len; i++) {

297:             require((ch >= "A" && ch <= "Z") || (ch >= "0" && ch <= "9") || (i > 0 && i < len - 1 && ch == "-"),

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentVaultManagementFacet.sol)

```solidity
File: ./contracts/assetManager/facets/AssetManagerBase.sol

4: import {Agents} from "../library/Agents.sol";

5: import {Globals} from "../library/Globals.sol";

6: import {AssetManagerState} from "../library/data/AssetManagerState.sol";

7: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AssetManagerBase.sol)

```solidity
File: ./contracts/assetManager/facets/AssetManagerDiamondCutFacet.sol

9: import { Globals } from "../library/Globals.sol";

10: import { IDiamondCut } from "../../diamond/interfaces/IDiamondCut.sol";

11: import { LibDiamond } from "../../diamond/library/LibDiamond.sol";

12: import { GovernedProxyImplementation } from "../../governance/implementation/GovernedProxyImplementation.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AssetManagerDiamondCutFacet.sol)

```solidity
File: ./contracts/assetManager/facets/AssetManagerInit.sol

4: import {IGovernanceSettings} from "@flarenetwork/flare-periphery-contracts/flare/IGovernanceSettings.sol";

5: import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";

6: import {ReentrancyGuard} from "../../openzeppelin/security/ReentrancyGuard.sol";

7: import {CollateralTypes} from "../library/CollateralTypes.sol";

8: import {SettingsInitializer} from "../library/SettingsInitializer.sol";

9: import {IIAssetManager} from "../../assetManager/interfaces/IIAssetManager.sol";

10: import {IDiamondCut} from "../../diamond/interfaces/IDiamondCut.sol";

11: import {IDiamondLoupe} from "../../diamond/interfaces/IDiamondLoupe.sol";

12: import {LibDiamond} from "../../diamond/library/LibDiamond.sol";

13: import {IGoverned} from "../../governance/interfaces/IGoverned.sol";

14: import {GovernedBase} from "../../governance/implementation/GovernedBase.sol";

15: import {GovernedProxyImplementation} from "../../governance/implementation/GovernedProxyImplementation.sol";

16: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

17: import {CollateralType} from "../../userInterfaces/data/CollateralType.sol";

18: import {IAgentPing} from "../../userInterfaces/IAgentPing.sol";

19: import {IAssetManager} from "../../userInterfaces/IAssetManager.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AssetManagerInit.sol)

```solidity
File: ./contracts/assetManager/facets/AvailableAgentsFacet.sol

4: import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

5: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

6: import {AssetManagerBase} from "./AssetManagerBase.sol";

7: import {AgentCollateral} from "../library/AgentCollateral.sol";

8: import {Agents} from "../library/Agents.sol";

9: import {Globals} from "../library/Globals.sol";

10: import {Agent} from "../library/data/Agent.sol";

11: import {AssetManagerState} from "../library/data/AssetManagerState.sol";

12: import {Collateral} from "../library/data/Collateral.sol";

13: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

14: import {AvailableAgentInfo} from "../../userInterfaces/data/AvailableAgentInfo.sol";

15: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

52:         agent.availableAgentsPos = state.availableAgents.length.toUint32();     // index+1 (0=not in list)

73:         _exitAllowedAt = block.timestamp + settings.agentExitAvailableTimelockSeconds;

95:         require(block.timestamp <= agent.exitAvailableAfterTs + settings.agentTimelockedOperationWindowSeconds,

97:         uint256 ind = agent.availableAgentsPos - 1;

98:         if (ind + 1 < state.availableAgents.length) {

99:             state.availableAgents[ind] = state.availableAgents[state.availableAgents.length - 1];

101:             movedAgent.availableAgentsPos = uint32(ind + 1);

126:         _agents = new address[](_end - _start);

127:         for (uint256 i = _start; i < _end; i++) {

128:             _agents[i - _start] = state.availableAgents[i];

152:         _agents = new AvailableAgentInfo.Data[](_end - _start);

153:         for (uint256 i = _start; i < _end; i++) {

159:             _agents[i - _start] = AvailableAgentInfo.Data({

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AvailableAgentsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/ChallengesFacet.sol

4: import {IBalanceDecreasingTransaction} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

5: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

6: import {AssetManagerBase} from "./AssetManagerBase.sol";

7: import {ReentrancyGuard} from "../../openzeppelin/security/ReentrancyGuard.sol";

8: import {AgentCollateral} from "../library/AgentCollateral.sol";

9: import {Agents} from "../library/Agents.sol";

10: import {AgentPayout} from "../library/AgentPayout.sol";

11: import {Conversion} from "../library/Conversion.sol";

12: import {Globals} from "../library/Globals.sol";

13: import {Liquidation} from "../library/Liquidation.sol";

14: import {Redemptions} from "../library/Redemptions.sol";

15: import {TransactionAttestation} from "../library/TransactionAttestation.sol";

16: import {UnderlyingBalance} from "../library/UnderlyingBalance.sol";

17: import {Agent} from "../library/data/Agent.sol";

18: import {AssetManagerState} from "../library/data/AssetManagerState.sol";

19: import {Collateral} from "../library/data/Collateral.sol";

20: import {PaymentConfirmations} from "../library/data/PaymentConfirmations.sol";

21: import {PaymentReference} from "../library/data/PaymentReference.sol";

22: import {Redemption} from "../library/data/Redemption.sol";

23: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

24: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

25: import {SafePct} from "../../utils/library/SafePct.sol";

155:         for (uint256 i = 0; i < _payments.length; i++) {

159:             for (uint256 j = 0; j < i; j++) {

166:                 continue;   // ignore payments that have already been confirmed

176:                 total += pmi.data.responseBody.spentAmount - SafeCast.toInt256(redemptionValue);

179:                 total += pmi.data.responseBody.spentAmount;

183:         int256 balanceAfterPayments = agent.underlyingBalanceUBA - total;

219:             + Agents.convertUSD5ToVaultCollateralWei(_agent, settings.paymentChallengeRewardUSD5);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/ChallengesFacet.sol)

```solidity
File: ./contracts/assetManager/facets/CollateralReservationsFacet.sol

4: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

5: import {AssetManagerBase} from "./AssetManagerBase.sol";

6: import {ReentrancyGuard} from "../../openzeppelin/security/ReentrancyGuard.sol";

7: import {SafePct} from "../../utils/library/SafePct.sol";

8: import {Transfers} from "../../utils/library/Transfers.sol";

9: import {AssetManagerState} from "../library/data/AssetManagerState.sol";

10: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

11: import {Conversion} from "../library/Conversion.sol";

12: import {Agents} from "../library/Agents.sol";

13: import {Minting} from "../library/Minting.sol";

14: import {AgentCollateral} from "../library/AgentCollateral.sol";

15: import {Collateral} from "../library/data/Collateral.sol";

16: import {Agent} from "../library/data/Agent.sol";

17: import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

18: import {CollateralReservation} from "../library/data/CollateralReservation.sol";

19: import {PaymentReference} from "../library/data/PaymentReference.sol";

20: import {Globals} from "../library/Globals.sol";

21: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

80:         _reserveCollateral(agent, valueAMG + _currentPoolFeeAMG(agent, valueAMG));

88:         state.newCrtId += PaymentReference.randomizedIdSkip();

96:         cr.poolFeeShareBIPS = agent.poolFeeShareBIPS + 1;

101:             cr.executorFeeNatGWei = ((msg.value - reservationFee) / Conversion.GWEI).toUint64();

114:             Transfers.transferNAT(payable(msg.sender), msg.value - reservationFee);

147:         _agent.reservedAMG += _reservationAMG;

148:         state.totalReservedCollateralAMG += _reservationAMG;

170:             _cr.executorFeeNatGWei * Conversion.GWEI);

192:         uint64 timeshift = block.timestamp.toUint64() - state.currentUnderlyingBlockUpdatedAt;

193:         uint64 blockshift = (uint256(timeshift) * 1000 / settings.averageBlockTimeMS).toUint64();

195:             state.currentUnderlyingBlock + blockshift + settings.underlyingBlocksForPayment;

197:             state.currentUnderlyingBlockTimestamp + timeshift + settings.underlyingSecondsForPayment;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/CollateralReservationsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/CollateralTypesFacet.sol

4: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

5: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

6: import {AssetManagerBase} from "./AssetManagerBase.sol";

7: import {CollateralTypes} from "../library/CollateralTypes.sol";

8: import {Globals} from "../library/Globals.sol";

9: import {SettingsUpdater} from "../library/SettingsUpdater.sol";

10: import {CollateralTypeInt} from "../library/data/CollateralTypeInt.sol";

11: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

12: import {CollateralType} from "../../userInterfaces/data/CollateralType.sol";

13: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

14: import {SafePct} from "../../utils/library/SafePct.sol";

85:         uint256 validUntil = block.timestamp + _invalidationTimeSec;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/CollateralTypesFacet.sol)

```solidity
File: ./contracts/assetManager/facets/CoreVaultClientFacet.sol

4: import {IPayment} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

5: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

6: import {ICoreVaultClient} from "../../userInterfaces/ICoreVaultClient.sol";

7: import {AssetManagerBase} from "./AssetManagerBase.sol";

8: import {ReentrancyGuard} from "../../openzeppelin/security/ReentrancyGuard.sol";

9: import {Conversion} from "../library/Conversion.sol";

10: import {CoreVaultClient} from "../library/CoreVaultClient.sol";

11: import {Agent} from "../library/data/Agent.sol";

12: import {SafePct} from "../../utils/library/SafePct.sol";

13: import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

14: import {AssetManagerState} from "../library/data/AssetManagerState.sol";

15: import {PaymentReference} from "../library/data/PaymentReference.sol";

16: import {AgentCollateral} from "../library/AgentCollateral.sol";

17: import {Redemptions} from "../library/Redemptions.sol";

18: import {RedemptionRequests} from "../library/RedemptionRequests.sol";

19: import {UnderlyingBalance} from "../library/UnderlyingBalance.sol";

20: import {Collateral} from "../library/data/Collateral.sol";

21: import {PaymentConfirmations} from "../library/data/PaymentConfirmations.sol";

22: import {AgentBacking} from "../library/AgentBacking.sol";

23: import {SafeMath64} from "../../utils/library/SafeMath64.sol";

24: import {TransactionAttestation} from "../library/TransactionAttestation.sol";

25: import {UnderlyingBlockUpdater} from "../library/UnderlyingBlockUpdater.sol";

143:         state.newTransferFromCoreVaultId += PaymentReference.randomizedIdSkip();

150:         agent.reservedAMG += amountAMG;

255:         uint128 paymentUBA = (redeemedUBA - redemptionFeeUBA).toUint128();

257:         state.newRedemptionFromCoreVaultId += PaymentReference.randomizedIdSkip();

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/CoreVaultClientFacet.sol)

```solidity
File: ./contracts/assetManager/facets/CoreVaultClientSettingsFacet.sol

4: import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";

5: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

6: import {AssetManagerBase} from "./AssetManagerBase.sol";

7: import {CoreVaultClient} from "../library/CoreVaultClient.sol";

8: import {IICoreVaultManager} from "../../coreVaultManager/interfaces/IICoreVaultManager.sol";

9: import {LibDiamond} from "../../diamond/library/LibDiamond.sol";

10: import {GovernedProxyImplementation} from "../../governance/implementation/GovernedProxyImplementation.sol";

11: import {ICoreVaultClientSettings} from "../../userInterfaces/ICoreVaultClientSettings.sol";

12: import {IAssetManager} from "../../userInterfaces/IAssetManager.sol";

13: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

14: import {ICoreVaultClient} from "../../userInterfaces/ICoreVaultClient.sol";

15: import {SafePct} from "../../utils/library/SafePct.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/CoreVaultClientSettingsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/EmergencyPauseFacet.sol

4: import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

5: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

6: import {AssetManagerBase} from "./AssetManagerBase.sol";

7: import {Globals} from "../library/Globals.sol";

8: import {AssetManagerState} from "../library/data/AssetManagerState.sol";

9: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

10: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

25:             state.emergencyPausedUntil = (block.timestamp + _duration).toUint64();

32:             if (state.emergencyPausedUntil + settings.emergencyPauseDurationResetAfterSeconds <= block.timestamp) {

37:                 Math.min(currentPauseEndTime - state.emergencyPausedTotalDuration, block.timestamp);

38:             uint256 maxEndTime = projectedStartTime + settings.maxEmergencyPauseDurationSeconds;

39:             uint256 endTime = Math.min(block.timestamp + _duration, maxEndTime);

41:             state.emergencyPausedTotalDuration = (endTime - projectedStartTime).toUint64();

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/EmergencyPauseFacet.sol)

```solidity
File: ./contracts/assetManager/facets/EmergencyPauseTransfersFacet.sol

4: import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

5: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

6: import {AssetManagerBase} from "./AssetManagerBase.sol";

7: import {Globals} from "../library/Globals.sol";

8: import {AssetManagerState} from "../library/data/AssetManagerState.sol";

9: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

10: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

25:             state.transfersEmergencyPausedUntil = (block.timestamp + _duration).toUint64();

32:             uint256 resetTs = state.transfersEmergencyPausedUntil + settings.emergencyPauseDurationResetAfterSeconds;

38:                 Math.min(currentPauseEndTime - state.transfersEmergencyPausedTotalDuration, block.timestamp);

39:             uint256 maxEndTime = projectedStartTime + settings.maxEmergencyPauseDurationSeconds;

40:             uint256 endTime = Math.min(block.timestamp + _duration, maxEndTime);

42:             state.transfersEmergencyPausedTotalDuration = (endTime - projectedStartTime).toUint64();

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/EmergencyPauseTransfersFacet.sol)

```solidity
File: ./contracts/assetManager/facets/LiquidationFacet.sol

4: import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

5: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

6: import {AssetManagerBase} from "./AssetManagerBase.sol";

7: import {ReentrancyGuard} from "../../openzeppelin/security/ReentrancyGuard.sol";

8: import {AgentPayout} from "../library/AgentPayout.sol";

9: import {Agents} from "../library/Agents.sol";

10: import {Conversion} from "../library/Conversion.sol";

11: import {Liquidation} from "../library/Liquidation.sol";

12: import {LiquidationPaymentStrategy} from "../library/LiquidationPaymentStrategy.sol";

13: import {Redemptions} from "../library/Redemptions.sol";

14: import {Agent} from "../library/data/Agent.sol";

15: import {AssetManagerState} from "../library/data/AssetManagerState.sol";

16: import {Collateral} from "../library/data/Collateral.sol";

17: import {CollateralTypeInt} from "../library/data/CollateralTypeInt.sol";

18: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

19: import {AgentInfo} from "../../userInterfaces/data/AgentInfo.sol";

20: import {SafePct} from "../../utils/library/SafePct.sol";

216:         } else {    // both collaterals were underwater - only half responsibility assigned to agent

217:             return _amount / 2;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/LiquidationFacet.sol)

```solidity
File: ./contracts/assetManager/facets/MintingDefaultsFacet.sol

5:     from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

6: import {SafePct} from "../../utils/library/SafePct.sol";

7: import {AssetManagerBase} from "./AssetManagerBase.sol";

8: import {IIAgentVault} from "../../agentVault/interfaces/IIAgentVault.sol";

9: import {ReentrancyGuard} from "../../openzeppelin/security/ReentrancyGuard.sol";

10: import {Transfers} from "../../utils/library/Transfers.sol";

11: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

12: import {Conversion} from "../library/Conversion.sol";

13: import {Agents} from "../library/Agents.sol";

14: import {Minting} from "../library/Minting.sol";

15: import {TransactionAttestation} from "../library/TransactionAttestation.sol";

16: import {Agent} from "../library/data/Agent.sol";

17: import {CollateralReservation} from "../library/data/CollateralReservation.sol";

18: import {PaymentReference} from "../library/data/PaymentReference.sol";

19: import {Globals} from "../library/Globals.sol";

20: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

21: import {CollateralTypeInt} from "../library/data/CollateralTypeInt.sol";

59:             _proof.data.requestBody.amount == underlyingValueUBA + crt.underlyingFeeUBA,

67:         uint256 reservedValueUBA = underlyingValueUBA + Minting.calculatePoolFeeUBA(agent, crt);

70:         uint256 totalFee = crt.reservationFeeNatWei + crt.executorFeeNatGWei * Conversion.GWEI;

106:             && _proof.data.responseBody.lowestQueryWindowBlockTimestamp + settings.attestationWindowSeconds <=

110:         Globals.getBurnAddress().transfer(crt.reservationFeeNatWei + crt.executorFeeNatGWei * Conversion.GWEI);

116:         uint256 reservedValueUBA = Conversion.convertAmgToUBA(crt.valueAMG) + Minting.calculatePoolFeeUBA(agent, crt);

121:         Transfers.transferNAT(payable(msg.sender), msg.value - burnedNatWei);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/MintingDefaultsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/MintingFacet.sol

4: import {IPayment} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

5: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

6: import {AssetManagerBase} from "./AssetManagerBase.sol";

7: import {ReentrancyGuard} from "../../openzeppelin/security/ReentrancyGuard.sol";

8: import {Minting} from "../library/Minting.sol";

9: import {SafePct} from "../../utils/library/SafePct.sol";

10: import {AssetManagerState} from "../library/data/AssetManagerState.sol";

11: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

12: import {Agents} from "../library/Agents.sol";

13: import {UnderlyingBalance} from "../library/UnderlyingBalance.sol";

14: import {AgentCollateral} from "../library/AgentCollateral.sol";

15: import {TransactionAttestation} from "../library/TransactionAttestation.sol";

16: import {PaymentConfirmations} from "../library/data/PaymentConfirmations.sol";

17: import {Collateral} from "../library/data/Collateral.sol";

18: import {Agent} from "../library/data/Agent.sol";

19: import {AgentBacking} from "../library/AgentBacking.sol";

20: import {CollateralReservation} from "../library/data/CollateralReservation.sol";

21: import {Conversion} from "../library/Conversion.sol";

22: import {Globals} from "../library/Globals.sol";

23: import {PaymentReference} from "../library/data/PaymentReference.sol";

24: import {UnderlyingBlockUpdater} from "../library/UnderlyingBlockUpdater.sol";

80:         require(_payment.data.responseBody.receivedAmount >= SafeCast.toInt256(mintValueUBA + crt.underlyingFeeUBA),

133:         Minting.checkMintingCap(valueAMG + Conversion.convertUBAToAmg(poolFeeUBA));

138:         require(_payment.data.responseBody.receivedAmount >= SafeCast.toInt256(mintValueUBA + poolFeeUBA),

147:         uint256 receivedAmount = uint256(_payment.data.responseBody.receivedAmount);  // guarded by require

185:         Minting.checkMintingCap(valueAMG + Conversion.convertUBAToAmg(poolFeeUBA));

186:         uint256 requiredUnderlyingAfter = UnderlyingBalance.requiredUnderlyingUBA(agent) + mintValueUBA + poolFeeUBA;

203:         AgentBacking.createNewMinting(_agent, _mintValueAMG + poolFeeAMG);

213:             uint256 agentFeeUBA = _receivedAmountUBA - mintValueUBA - _poolFeeUBA;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/MintingFacet.sol)

```solidity
File: ./contracts/assetManager/facets/RedemptionConfirmationsFacet.sol

4: import {IPayment} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

5: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

6: import {AssetManagerBase} from "./AssetManagerBase.sol";

7: import {ReentrancyGuard} from "../../openzeppelin/security/ReentrancyGuard.sol";

8: import {AssetManagerState} from "../library/data/AssetManagerState.sol";

9: import {SafePct} from "../../utils/library/SafePct.sol";

10: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

11: import {Redemptions} from "../library/Redemptions.sol";

12: import {RedemptionDefaults} from "../library/RedemptionDefaults.sol";

13: import {Liquidation} from "../library/Liquidation.sol";

14: import {UnderlyingBalance} from "../library/UnderlyingBalance.sol";

15: import {CoreVaultClient} from "../library/CoreVaultClient.sol";

16: import {Agent} from "../library/data/Agent.sol";

17: import {PaymentConfirmations} from "../library/data/PaymentConfirmations.sol";

18: import {Redemption} from "../library/data/Redemption.sol";

19: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

20: import {Globals} from "../library/Globals.sol";

21: import {TransactionAttestation} from "../library/TransactionAttestation.sol";

22: import {Agents} from "../library/Agents.sol";

23: import {AgentBacking} from "../library/AgentBacking.sol";

24: import {AgentPayout} from "../library/AgentPayout.sol";

25: import {Conversion} from "../library/Conversion.sol";

26: import {PaymentReference} from "../library/data/PaymentReference.sol";

27: import {UnderlyingBlockUpdater} from "../library/UnderlyingBlockUpdater.sol";

94:             assert(request.status == Redemption.Status.ACTIVE); // checked in _validatePayment that is not DEFAULTED

127:         UnderlyingBalance.updateBalance(agent, -_payment.data.responseBody.spentAmount);

171:         return block.timestamp > _request.timestamp + settings.confirmationByOthersAfterSeconds;

181:         uint256 paymentValueUBA = uint256(request.underlyingValueUBA) - request.underlyingFeeUBA;

186:         } else if (_payment.data.responseBody.receivedAmount < int256(paymentValueUBA)) { // paymentValueUBA < 2**128

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/RedemptionConfirmationsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/RedemptionDefaultsFacet.sol

5:     from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

6: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

7: import {AssetManagerBase} from "./AssetManagerBase.sol";

8: import {ReentrancyGuard} from "../../openzeppelin/security/ReentrancyGuard.sol";

9: import {RedemptionDefaults} from "../library/RedemptionDefaults.sol";

10: import {Redemptions} from "../library/Redemptions.sol";

11: import {TransactionAttestation} from "../library/TransactionAttestation.sol";

12: import {Agent} from "../library/data/Agent.sol";

13: import {Agents} from "../library/Agents.sol";

14: import {AgentPayout} from "../library/AgentPayout.sol";

15: import {Redemption} from "../library/data/Redemption.sol";

16: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

17: import {PaymentReference} from "../library/data/PaymentReference.sol";

18: import {Globals} from "../library/Globals.sol";

61:             _proof.data.requestBody.amount == request.underlyingValueUBA - request.underlyingFeeUBA,

118:                 && _proof.data.responseBody.lowestQueryWindowBlockTimestamp + settings.attestationWindowSeconds <=

141:             block.timestamp > _request.timestamp + settings.confirmationByOthersAfterSeconds;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/RedemptionDefaultsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/RedemptionRequestsFacet.sol

4: import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

5: import {IAddressValidity} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

6: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

7: import {AssetManagerBase} from "./AssetManagerBase.sol";

8: import {ReentrancyGuard} from "../../openzeppelin/security/ReentrancyGuard.sol";

9: import {Agents} from "../library/Agents.sol";

10: import {AgentBacking} from "../library/AgentBacking.sol";

11: import {AgentPayout} from "../library/AgentPayout.sol";

12: import {Globals} from "../library/Globals.sol";

13: import {RedemptionRequests} from "../library/RedemptionRequests.sol";

14: import {Agent} from "../library/data/Agent.sol";

15: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

16: import {SafePct} from "../../utils/library/SafePct.sol";

17: import {AssetManagerState} from "../library/data/AssetManagerState.sol";

18: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

19: import {Conversion} from "../library/Conversion.sol";

20: import {Redemptions} from "../library/Redemptions.sol";

21: import {Liquidation} from "../library/Liquidation.sol";

22: import {TransactionAttestation} from "../library/TransactionAttestation.sol";

23: import {RedemptionQueue} from "../library/data/RedemptionQueue.sol";

24: import {Redemption} from "../library/data/Redemption.sol";

74:         for (uint256 i = 0; i < maxRedeemedTickets && redeemedLots < _lots; i++) {

81:             redeemedLots += _redeemFirstTicket(_lots - redeemedLots, redemptionList);

83:         uint256 executorFeeNatGWei = msg.value / Conversion.GWEI;

84:         for (uint256 i = 0; i < redemptionList.length; i++) {

86:             uint256 currentExecutorFeeNatGWei = executorFeeNatGWei / (redemptionList.length - i);

87:             executorFeeNatGWei -= currentExecutorFeeNatGWei;

93:             emit IAssetManagerEvents.RedemptionRequestIncomplete(msg.sender, _lots - redeemedLots);

126:             _executor, (msg.value / Conversion.GWEI).toUint64(), 0, false);

178:         for (uint256 i = 0; ticketId != 0 && i < maxRedeemedTickets; i++) {

180:             maxRedemptionAMG += ticket.valueAMG;

203:         assert(!request.transferToCoreVault);   // we have a problem if core vault has invalid address

284:             uint64 ticketValueAMG = agent.dustAMG - remainingDustAMG;

301:             return 0;    // empty redemption queue

306:         uint256 maxRedeemLots = (ticket.valueAMG + agent.dustAMG) / settings.lotSizeAMG;

313:                 ++index;

317:                 _list.items[index].valueAMG = _list.items[index].valueAMG + redeemedAMG;

319:                 _list.items[_list.length++] = RedemptionRequests.AgentRedemptionData({

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/RedemptionRequestsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/RedemptionTimeExtensionFacet.sol

4: import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";

5: import {AssetManagerBase} from "./AssetManagerBase.sol";

6: import {Globals} from "../library/Globals.sol";

7: import {SettingsUpdater} from "../library/SettingsUpdater.sol";

8: import {RedemptionTimeExtension} from "../library/data/RedemptionTimeExtension.sol";

9: import {LibDiamond} from "../../diamond/library/LibDiamond.sol";

10: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

11: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

12: import {IRedemptionTimeExtension} from "../../userInterfaces/IRedemptionTimeExtension.sol";

49:         require(_value <= currentValue * 4 + settings.averageBlockTimeMS / 1000, IncreaseTooBig());

50:         require(_value >= currentValue / 4, DecreaseTooBig());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/RedemptionTimeExtensionFacet.sol)

```solidity
File: ./contracts/assetManager/facets/SettingsManagementFacet.sol

4: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

5: import {AssetManagerBase} from "./AssetManagerBase.sol";

6: import {IISettingsManagement} from "../interfaces/IISettingsManagement.sol";

7: import {CollateralTypes} from "../library/CollateralTypes.sol";

8: import {Globals} from "../library/Globals.sol";

9: import {SettingsUpdater} from "../library/SettingsUpdater.sol";

10: import {SettingsValidators} from "../library/SettingsValidators.sol";

11: import {IIFAsset} from "../../fassetToken/interfaces/IIFAsset.sol";

12: import {IWNat} from "../../flareSmartContracts/interfaces/IWNat.sol";

13: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

14: import {CollateralType} from "../../userInterfaces/data/CollateralType.sol";

15: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

16: import {IUpgradableProxy} from "../../utils/interfaces/IUpgradableProxy.sol";

17: import {SafePct} from "../../utils/library/SafePct.sol";

216:         require(_rewardNATWei <= (settings.paymentChallengeRewardUSD5 * 4) + 100 ether, IncreaseTooBig());

217:         require(_rewardNATWei >= (settings.paymentChallengeRewardUSD5) / 4, DecreaseTooBig());

218:         require(_rewardBIPS <= (settings.paymentChallengeRewardBIPS * 4) + 100, IncreaseTooBig());

219:         require(_rewardBIPS >= (settings.paymentChallengeRewardBIPS) / 4, DecreaseTooBig());

250:         require(_value <= settings.lotSizeAMG * 10, LotSizeIncreaseTooBig());

251:         require(_value >= settings.lotSizeAMG / 10, LotSizeDecreaseTooBig());

267:         require(_value <= settings.maxTrustedPriceAgeSeconds * 2, FeeIncreaseTooBig());

268:         require(_value >= settings.maxTrustedPriceAgeSeconds / 2, FeeDecreaseTooBig());

283:         require(_value <= settings.collateralReservationFeeBIPS * 4, FeeIncreaseTooBig());

284:         require(_value >= settings.collateralReservationFeeBIPS / 4, FeeDecreaseTooBig());

299:         require(_value <= settings.redemptionFeeBIPS * 4, FeeIncreaseTooBig());

300:         require(_value >= settings.redemptionFeeBIPS / 4, FeeDecreaseTooBig());

315:         require(_value <= uint256(settings.redemptionDefaultFactorVaultCollateralBIPS).mulBips(12000) + 1000,

345:         require(_value <= settings.confirmationByOthersRewardUSD5 * 4, FeeIncreaseTooBig());

346:         require(_value >= settings.confirmationByOthersRewardUSD5 / 4, FeeDecreaseTooBig());

360:         require(_value <= settings.maxRedeemedTickets * 2, IncreaseTooBig());

361:         require(_value >= settings.maxRedeemedTickets / 4, DecreaseTooBig());

376:         require(_value <= settings.withdrawalWaitMinSeconds + 10 minutes, IncreaseTooBig());

403:         require(_value <= settings.averageBlockTimeMS * 2, IncreaseTooBig());

404:         require(_value >= settings.averageBlockTimeMS / 2, DecreaseTooBig());

417:         require(_value <= settings.mintingPoolHoldingsRequiredBIPS * 4 + SafePct.MAX_BIPS, ValueTooBig());

468:         require(_value <= settings.agentExitAvailableTimelockSeconds * 4 + 1 weeks, ValueTooBig());

481:         require(_value <= settings.agentFeeChangeTimelockSeconds * 4 + 1 days, ValueTooBig());

494:         require(_value <= settings.agentMintingCRChangeTimelockSeconds * 4 + 1 days, ValueTooBig());

507:         require(_value <= settings.poolExitCRChangeTimelockSeconds * 4 + 1 days, ValueTooBig());

547:         require(_stepSeconds <= settings.liquidationStepSeconds * 2, IncreaseTooBig());

548:         require(_stepSeconds >= settings.liquidationStepSeconds / 2, DecreaseTooBig());

568:         for (uint256 i = 0; i < _liquidationFactors.length; i++) {

585:         require(_value <= settings.maxEmergencyPauseDurationSeconds * 4 + 60, IncreaseTooBig());

586:         require(_value >= settings.maxEmergencyPauseDurationSeconds / 4, DecreaseTooBig());

601:         require(_value <= settings.emergencyPauseDurationResetAfterSeconds * 4 + 3600, IncreaseTooBig());

602:         require(_value >= settings.emergencyPauseDurationResetAfterSeconds / 4, DecreaseTooBig());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/SettingsManagementFacet.sol)

```solidity
File: ./contracts/assetManager/facets/SettingsReaderFacet.sol

4: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

5: import {AssetManagerBase} from "./AssetManagerBase.sol";

6: import {Globals} from "../library/Globals.sol";

7: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

50:         return uint256(settings.lotSizeAMG) * settings.assetMintingGranularityUBA;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/SettingsReaderFacet.sol)

```solidity
File: ./contracts/assetManager/facets/SystemInfoFacet.sol

4: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

5: import {AssetManagerBase} from "./AssetManagerBase.sol";

6: import {AssetManagerState} from "../library/data/AssetManagerState.sol";

7: import {Conversion} from "../library/Conversion.sol";

8: import {RedemptionQueueInfo} from "../library/RedemptionQueueInfo.sol";

9: import {Minting} from "../library/Minting.sol";

10: import {Redemptions} from "../library/Redemptions.sol";

11: import {Agent} from "../library/data/Agent.sol";

12: import {CollateralReservation} from "../library/data/CollateralReservation.sol";

13: import {PaymentReference} from "../library/data/PaymentReference.sol";

14: import {Redemption} from "../library/data/Redemption.sol";

15: import {CollateralReservationInfo} from "../../userInterfaces/data/CollateralReservationInfo.sol";

16: import {RedemptionRequestInfo} from "../../userInterfaces/data/RedemptionRequestInfo.sol";

17: import {RedemptionTicketInfo} from "../../userInterfaces/data/RedemptionTicketInfo.sol";

96:             poolFeeShareBIPS: crt.poolFeeShareBIPS > 0 ? crt.poolFeeShareBIPS - 1 : agent.poolFeeShareBIPS,

101:             executorFeeNatWei: crt.executorFeeNatGWei * Conversion.GWEI,

131:             executorFeeNatWei: request.executorFeeNatGWei * Conversion.GWEI

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/SystemInfoFacet.sol)

```solidity
File: ./contracts/assetManager/facets/SystemStateManagementFacet.sol

4: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

5: import {AssetManagerBase} from "./AssetManagerBase.sol";

6: import {AssetManagerState} from "../library/data/AssetManagerState.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/SystemStateManagementFacet.sol)

```solidity
File: ./contracts/assetManager/facets/UnderlyingBalanceFacet.sol

4: import {IPayment} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

5: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

6: import {AssetManagerBase} from "./AssetManagerBase.sol";

7: import {ReentrancyGuard} from "../../openzeppelin/security/ReentrancyGuard.sol";

8: import {Agents} from "../library/Agents.sol";

9: import {AgentPayout} from "../library/AgentPayout.sol";

10: import {Globals} from "../library/Globals.sol";

11: import {TransactionAttestation} from "../library/TransactionAttestation.sol";

12: import {UnderlyingBalance} from "../library/UnderlyingBalance.sol";

13: import {Agent} from "../library/data/Agent.sol";

14: import {PaymentConfirmations} from "../library/data/PaymentConfirmations.sol";

15: import {PaymentReference} from "../library/data/PaymentReference.sol";

16: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

17: import {AssetManagerState} from "../library/data/AssetManagerState.sol";

18: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

19: import {UnderlyingBlockUpdater} from "../library/UnderlyingBlockUpdater.sol";

86:         state.newPaymentAnnouncementId += PaymentReference.randomizedIdSkip();

123:                 agent.underlyingWithdrawalAnnouncedAt + settings.confirmationByOthersAfterSeconds,

130:         UnderlyingBalance.updateBalance(agent, -_payment.data.responseBody.spentAmount);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/UnderlyingBalanceFacet.sol)

```solidity
File: ./contracts/assetManager/facets/UnderlyingTimekeepingFacet.sol

4: import {IConfirmedBlockHeightExists} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

5: import {AssetManagerBase} from "./AssetManagerBase.sol";

6: import {UnderlyingBlockUpdater} from "../library/UnderlyingBlockUpdater.sol";

7: import {AssetManagerState} from "../library/data/AssetManagerState.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/UnderlyingTimekeepingFacet.sol)

```solidity
File: ./contracts/assetManager/implementation/AssetManager.sol

4: import {Diamond} from "../../diamond/implementation/Diamond.sol";

5: import {LibDiamond} from "../../diamond/library/LibDiamond.sol";

6: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

7: import {IDiamondCut} from "../../diamond/interfaces/IDiamondCut.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/implementation/AssetManager.sol)

```solidity
File: ./contracts/assetManager/library/AgentBacking.sol

4: import {AssetManagerState} from "./data/AssetManagerState.sol";

5: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

6: import {Globals} from "./Globals.sol";

7: import {Conversion} from "./Conversion.sol";

8: import {Agent} from "./data/Agent.sol";

9: import {RedemptionQueue} from "./data/RedemptionQueue.sol";

10: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

23:         _agent.mintedAMG = _agent.mintedAMG - _valueAMG;

33:         _agent.redeemingAMG += _valueAMG;

35:             _agent.poolRedeemingAMG += _valueAMG;

47:         _agent.redeemingAMG = _agent.redeemingAMG - _valueAMG;

49:             _agent.poolRedeemingAMG = _agent.poolRedeemingAMG - _valueAMG;

60:         _agent.mintedAMG += _valueAMG;

65:         uint64 valueWithDustAMG = _agent.dustAMG + _valueAMG;

67:         uint64 ticketValueAMG = valueWithDustAMG - newDustAMG;

88:             lastTicket.valueAMG += _ticketValueAMG;

117:         uint64 newDustAMG = _agent.dustAMG - _dustDecreaseAMG;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/AgentBacking.sol)

```solidity
File: ./contracts/assetManager/library/AgentCollateral.sol

4: import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

5: import {SafePct} from "../../utils/library/SafePct.sol";

6: import {MathUtils} from "../../utils/library/MathUtils.sol";

7: import {Collateral} from "./data/Collateral.sol";

8: import {Conversion} from "./Conversion.sol";

9: import {Agents} from "./Agents.sol";

10: import {Agent} from "./data/Agent.sol";

11: import {CollateralTypeInt} from "./data/CollateralTypeInt.sol";

12: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

13: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

14: import {Globals} from "./Globals.sol";

92:             : _poolCollateral.amgToTokenWeiPrice;   // price for empty pool is 1 token/NAT

137:         return lotWei != 0 ? collateralWei / lotWei : 0;

161:         uint256 backedAMG = uint256(_agent.reservedAMG) + uint256(_agent.mintedAMG);

169:         return mintingCollateral + redeemingCollateral + announcedWithdrawal;

195:         uint256 totalMintAmountAMG = _amountAMG + amountPoolFeeAMG;

241:         uint256 totalAMG = uint256(_agent.mintedAMG) + uint256(_agent.reservedAMG) + uint256(redeemingAMG);

242:         return _data.fullCollateral.mulDiv(_valueAMG, totalAMG); // totalAMG > 0 (guarded by assert)

256:         if (backingTokenWei == 0) return 1e10;    // nothing minted - ~infinite collateral ratio (but avoid overflows)

268:         return uint256(_agent.mintedAMG) + uint256(_agent.reservedAMG) + uint256(redeemingAMG);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/AgentCollateral.sol)

```solidity
File: ./contracts/assetManager/library/AgentPayout.sol

4: import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

5: import {IIAgentVault} from "../../agentVault/interfaces/IIAgentVault.sol";

6: import {Globals} from "./Globals.sol";

7: import {Agent} from "./data/Agent.sol";

8: import {CollateralTypeInt} from "./data/CollateralTypeInt.sol";

9: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

10: import {Agents} from "./Agents.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/AgentPayout.sol)

```solidity
File: ./contracts/assetManager/library/AgentUpdates.sol

4: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

5: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

6: import {SafePct} from "../../utils/library/SafePct.sol";

7: import {Agent} from "./data/Agent.sol";

8: import {Collateral} from "./data/Collateral.sol";

9: import {AssetManagerState} from "./data/AssetManagerState.sol";

10: import {CollateralTypeInt} from "./data/CollateralTypeInt.sol";

11: import {Agents} from "./Agents.sol";

12: import {CollateralTypes} from "./CollateralTypes.sol";

13: import {AgentCollateral} from "./AgentCollateral.sol";

14: import {CollateralType} from "../../userInterfaces/data/CollateralType.sol";

128:         require(_poolExitCollateralRatioBIPS <= currentExitCR * 3 / 2 ||

129:                 _poolExitCollateralRatioBIPS <= minCR * 12 / 10,

132:         require(_poolExitCollateralRatioBIPS <= minCR * 3, ValueTooHigh());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/AgentUpdates.sol)

```solidity
File: ./contracts/assetManager/library/Agents.sol

4: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

5: import {SafePct} from "../../utils/library/SafePct.sol";

6: import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

7: import {AssetManagerState} from "./data/AssetManagerState.sol";

8: import {Collateral} from "./data/Collateral.sol";

9: import {Globals} from "./Globals.sol";

10: import {Conversion} from "./Conversion.sol";

11: import {Agent} from "./data/Agent.sol";

12: import {RedemptionQueue} from "./data/RedemptionQueue.sol";

13: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

14: import {CollateralTypeInt} from "./data/CollateralTypeInt.sol";

15: import {IWNat} from "../../flareSmartContracts/interfaces/IWNat.sol";

16: import {AgentInfo} from "../../userInterfaces/data/AgentInfo.sol";

40:         _agents = new address[](_end - _start);

41:         for (uint256 i = _start; i < _end; i++) {

42:             _agents[i - _start] = state.allAgents[i];

186:         assert (_kind != Collateral.Kind.AGENT_POOL);   // there is no agent pool collateral token

213:         assert (_kind != Collateral.Kind.POOL);     // agent cannot withdraw from pool

226:         return _agent.mintedAMG + _agent.reservedAMG + _agent.redeemingAMG;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Agents.sol)

```solidity
File: ./contracts/assetManager/library/CollateralTypes.sol

4: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

5: import {SafePct} from "../../utils/library/SafePct.sol";

6: import {AssetManagerState} from "./data/AssetManagerState.sol";

7: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

8: import {CollateralType} from "../../userInterfaces/data/CollateralType.sol";

9: import {CollateralTypeInt} from "./data/CollateralTypeInt.sol";

10: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

11: import {Conversion} from "./Conversion.sol";

38:         for (uint256 i = 1; i < _data.length; i++) {

80:         for (uint256 i = 0; i < length; i++) {

95:         return state.collateralTokens[index - 1];

108:         return index - 1;

160:             __ccbMinCollateralRatioBIPS: 0, // no longer used

163:         state.collateralTokenIndex[tokenKey] = newTokenIndex + 1;   // 0 means empty

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/CollateralTypes.sol)

```solidity
File: ./contracts/assetManager/library/Conversion.sol

4: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

5: import {IPriceReader} from "../../ftso/interfaces/IPriceReader.sol";

6: import {SafePct} from "../../utils/library/SafePct.sol";

7: import {AssetManagerState} from "./data/AssetManagerState.sol";

8: import {Globals} from "./Globals.sol";

9: import {CollateralTypeInt} from "./data/CollateralTypeInt.sol";

10: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

17:     uint256 internal constant AMG_TOKEN_WEI_PRICE_SCALE = 10 ** AMG_TOKEN_WEI_PRICE_SCALE_EXP;

51:         bool trustedPriceFresh = tokenTimestampTrusted + settings.maxTrustedPriceAgeSeconds >= tokenTimestamp

52:                 && assetTimestampTrusted + settings.maxTrustedPriceAgeSeconds >= assetTimestamp;

65:         return uint256(_valueAMG) * settings.assetMintingGranularityUBA;

75:         return SafeCast.toUint64(_valueUBA / settings.assetMintingGranularityUBA);

85:         return _valueUBA - (_valueUBA % settings.assetMintingGranularityUBA);

95:         return SafeCast.toUint64(_lots * settings.lotSizeAMG);

106:         return _lots * settings.lotSizeAMG * settings.assetMintingGranularityUBA;

136:         uint256 expPlus = _token.decimals + tokenFtsoDec - 5;

137:         return _amountUSD5.mulDiv(10 ** expPlus, tokenPrice);

145:         returns (uint256 /*_price*/, uint256 /*_assetTimestamp*/, uint256 /*_tokenTimestamp*/)

185:         uint256 expPlus = _tokenDecimals + _tokenFtsoDecimals + AMG_TOKEN_WEI_PRICE_SCALE_EXP;

186:         uint256 expMinus = settings.assetMintingDecimals + _assetFtsoDecimals;

191:         return _assetPrice.mulDiv(10 ** (expPlus - expMinus), _tokenPrice);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Conversion.sol)

```solidity
File: ./contracts/assetManager/library/CoreVaultClient.sol

4: import {IICoreVaultManager} from "../../coreVaultManager/interfaces/IICoreVaultManager.sol";

5: import {MathUtils} from "../../utils/library/MathUtils.sol";

6: import {SafePct} from "../../utils/library/SafePct.sol";

7: import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

8: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

9: import {ICoreVaultClient} from "../../userInterfaces/ICoreVaultClient.sol";

10: import {AgentCollateral} from "./AgentCollateral.sol";

11: import {Redemptions} from "./Redemptions.sol";

12: import {Agent} from "./data/Agent.sol";

13: import {Collateral} from "./data/Collateral.sol";

14: import {IPayment} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

15: import {Redemption} from "./data/Redemption.sol";

16: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

17: import {Globals} from "./Globals.sol";

18: import {Conversion} from "./Conversion.sol";

19: import {ICoreVaultClient} from "../../userInterfaces/ICoreVaultClient.sol";

34:         uint16 __transferFeeBIPS; // only storage placeholder

89:         _agent.reservedAMG -= _agent.returnFromCoreVaultReservedAMG;

113:             state.coreVaultManager.totalRequestAmountWithFee() + coreVaultUnderlyingPaymentFee();

115:         _totalAvailableUBA = MathUtils.subOrZero(availableFunds + escrowedFunds, requestedAmountWithFee);

124:         return Conversion.convertUBAToAmg(totalAmountUBA) / settings.lotSizeAMG;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/CoreVaultClient.sol)

```solidity
File: ./contracts/assetManager/library/Globals.sol

4: import {IIFAsset} from "../../fassetToken/interfaces/IIFAsset.sol";

5: import {IWNat} from "../../flareSmartContracts/interfaces/IWNat.sol";

6: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

7: import {IAgentOwnerRegistry} from "../../userInterfaces/IAgentOwnerRegistry.sol";

8: import {AssetManagerState} from "./data/AssetManagerState.sol";

9: import {CollateralTypeInt} from "./data/CollateralTypeInt.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Globals.sol)

```solidity
File: ./contracts/assetManager/library/Liquidation.sol

4: import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

5: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

6: import {SafePct} from "../../utils/library/SafePct.sol";

7: import {MathUtils} from "../../utils/library/MathUtils.sol";

8: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

9: import {Agents} from "./Agents.sol";

10: import {Conversion} from "./Conversion.sol";

11: import {AgentCollateral} from "./AgentCollateral.sol";

12: import {Agent} from "./data/Agent.sol";

13: import {Collateral} from "./data/Collateral.sol";

14: import {CollateralTypeInt} from "./data/CollateralTypeInt.sol";

15: import {CollateralTypes} from "./CollateralTypes.sol";

122:             return 0;               // agent already safe

125:             return _agent.mintedAMG; // cannot achieve target - liquidate all

128:             .mulDivRoundUp(targetRatioBIPS - _collateralRatioBIPS, targetRatioBIPS - _factorBIPS);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Liquidation.sol)

```solidity
File: ./contracts/assetManager/library/LiquidationPaymentStrategy.sol

4: import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

5: import {Agents} from "./Agents.sol";

6: import {CollateralTypes} from "./CollateralTypes.sol";

7: import {Agent} from "./data/Agent.sol";

8: import {CollateralTypeInt} from "./data/CollateralTypeInt.sol";

9: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

10: import {Globals} from "./Globals.sol";

48:         _poolFactorBIPS = factorBIPS - _c1FactorBIPS;

51:             _c1FactorBIPS = Math.min(factorBIPS - _poolFactorBIPS, _vaultCR);

66:         uint256 step = (block.timestamp - liquidationStart) / settings.liquidationStepSeconds;

67:         return Math.min(step, settings.liquidationCollateralFactorBIPS.length - 1);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/LiquidationPaymentStrategy.sol)

```solidity
File: ./contracts/assetManager/library/Minting.sol

4: import {SafePct} from "../../utils/library/SafePct.sol";

5: import {Transfers} from "../../utils/library/Transfers.sol";

6: import {AssetManagerState} from "./data/AssetManagerState.sol";

7: import {Agents} from "./Agents.sol";

8: import {Agent} from "./data/Agent.sol";

9: import {CollateralReservation} from "./data/CollateralReservation.sol";

10: import {Conversion} from "./Conversion.sol";

11: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

12: import {Globals} from "./Globals.sol";

13: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

31:         Transfers.depositWNat(Globals.getWNat(), Agents.getOwnerPayAddress(_agent), _fee - poolFeeShare);

40:         uint256 executorFeeNatWei = _crt.executorFeeNatGWei * Conversion.GWEI;

59:         uint64 reservationAMG = _crt.valueAMG + Conversion.convertUBAToAmg(calculatePoolFeeUBA(agent, _crt));

60:         agent.reservedAMG = agent.reservedAMG - reservationAMG;

61:         state.totalReservedCollateralAMG -= reservationAMG;

90:         if (mintingCapAMG == 0) return;     // minting cap disabled

92:         uint256 totalAMG = state.totalReservedCollateralAMG + Conversion.convertUBAToAmg(totalMintedUBA);

93:         require(totalAMG + _increaseAMG <= mintingCapAMG, MintingCapExceeded());

106:         uint16 poolFeeShareBIPS = storedPoolFeeShareBIPS > 0 ? storedPoolFeeShareBIPS - 1 : _agent.poolFeeShareBIPS;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Minting.sol)

```solidity
File: ./contracts/assetManager/library/RedemptionDefaults.sol

4: import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

5: import {SafePct} from "../../utils/library/SafePct.sol";

6: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

7: import {Conversion} from "./Conversion.sol";

8: import {AgentCollateral} from "./AgentCollateral.sol";

9: import {CoreVaultClient} from "./CoreVaultClient.sol";

10: import {Agent} from "./data/Agent.sol";

11: import {AgentPayout} from "./AgentPayout.sol";

12: import {AgentBacking} from "./AgentBacking.sol";

13: import {Collateral} from "./data/Collateral.sol";

14: import {Redemption} from "./data/Redemption.sol";

15: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

16: import {Globals} from "./Globals.sol";

86:             uint256(_agent.reservedAMG + _agent.mintedAMG + _agent.redeemingAMG - _request.valueAMG)

89:         require(requiredPoolTokensForRemainder + poolTokenEquiv <= cd.agentPoolTokens.fullCollateral,

94:         uint256 combinedPaidPoolWei = _paidPoolWei + poolWeiEquiv;

130:                     .mulDivRoundUp(_vaultCollateralWei - maxVaultCollateralWei, _vaultCollateralWei);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/RedemptionDefaults.sol)

```solidity
File: ./contracts/assetManager/library/RedemptionQueueInfo.sol

4: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

5: import {AssetManagerState} from "./data/AssetManagerState.sol";

6: import {Conversion} from "./Conversion.sol";

7: import {RedemptionTicketInfo} from "../../userInterfaces/data/RedemptionTicketInfo.sol";

8: import {RedemptionQueue} from "./data/RedemptionQueue.sol";

9: import {Agent} from "./data/Agent.sol";

55:             ++count;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/RedemptionQueueInfo.sol)

```solidity
File: ./contracts/assetManager/library/RedemptionRequests.sol

4: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

5: import {SafePct} from "../../utils/library/SafePct.sol";

6: import {AssetManagerState} from "./data/AssetManagerState.sol";

7: import {RedemptionTimeExtension} from "./data/RedemptionTimeExtension.sol";

8: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

9: import {Conversion} from "./Conversion.sol";

10: import {Redemption} from "./data/Redemption.sol";

11: import {Agent} from "./data/Agent.sol";

12: import {Globals} from "./Globals.sol";

13: import {AgentBacking} from "./AgentBacking.sol";

14: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

15: import {PaymentReference} from "./data/PaymentReference.sol";

110:             _request.executorFeeNatGWei * Conversion.GWEI);

118:         uint64 nextRequestId = state.newRedemptionRequestId + PaymentReference.randomizedIdSkip();

121:         uint64 requestId = ((nextRequestId + 1) & ~uint64(1)) | (_poolSelfClose ? 1 : 0);

134:         uint64 timeshift = block.timestamp.toUint64() - state.currentUnderlyingBlockUpdatedAt

135:             + RedemptionTimeExtension.extendTimeForRedemption(_agentVault)

136:             + _additionalPaymentTime;

137:         uint64 blockshift = (uint256(timeshift) * 1000 / settings.averageBlockTimeMS).toUint64();

139:             state.currentUnderlyingBlock + blockshift + settings.underlyingBlocksForPayment;

141:             state.currentUnderlyingBlockTimestamp + timeshift + settings.underlyingSecondsForPayment;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/RedemptionRequests.sol)

```solidity
File: ./contracts/assetManager/library/Redemptions.sol

4: import {SafeMath64} from "../../utils/library/SafeMath64.sol";

5: import {Transfers} from "../../utils/library/Transfers.sol";

6: import {AssetManagerState} from "./data/AssetManagerState.sol";

7: import {Conversion} from "./Conversion.sol";

8: import {AgentBacking} from "./AgentBacking.sol";

9: import {Agent} from "../../assetManager/library/data/Agent.sol";

10: import {RedemptionQueue} from "./data/RedemptionQueue.sol";

11: import {Redemption} from "./data/Redemption.sol";

12: import {Globals} from "./Globals.sol";

13: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

34:         for (uint256 i = 0; i < maxRedeemedTickets && _closedAMG < _amountAMG; i++) {

38:                 break;  // no more tickets for this agent

41:             uint64 maxTicketRedeemAMG = ticket.valueAMG + _agent.dustAMG;

42:             maxTicketRedeemAMG -= maxTicketRedeemAMG % lotSize; // round down to whole lots

43:             uint64 ticketRedeemAMG = SafeMath64.min64(_amountAMG - _closedAMG, maxTicketRedeemAMG);

46:             _closedAMG += ticketRedeemAMG;

49:         uint64 closeDustAMG = SafeMath64.min64(_amountAMG - _closedAMG, _agent.dustAMG);

51:             _closedAMG += closeDustAMG;

72:         uint64 remainingAMG = ticket.valueAMG + agent.dustAMG - _redeemedAMG;

74:         uint64 remainingAMGLots = remainingAMG - remainingAMGDust;

101:         uint256 executorFeeNatWei = _request.executorFeeNatGWei * Conversion.GWEI;

118:         uint256 executorFeeNatWei = _request.executorFeeNatGWei * Conversion.GWEI;

142:         assert(_status >= Redemption.Status.SUCCESSFUL);    // must be a final status

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Redemptions.sol)

```solidity
File: ./contracts/assetManager/library/SettingsInitializer.sol

4: import {SafePct} from "../../utils/library/SafePct.sol";

5: import {Globals} from "./Globals.sol";

6: import {SettingsValidators} from "./SettingsValidators.sol";

7: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/SettingsInitializer.sol)

```solidity
File: ./contracts/assetManager/library/SettingsUpdater.sol

4: import {Globals} from "./Globals.sol";

5: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

25:         require(lastUpdate == 0 || block.timestamp >= lastUpdate + settings.minUpdateRepeatTimeSeconds,

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/SettingsUpdater.sol)

```solidity
File: ./contracts/assetManager/library/SettingsValidators.sol

4: import {SafePct} from "../../utils/library/SafePct.sol";

27:         require(_underlyingBlocks * _averageBlockTimeMS / 1000 <= MAXIMUM_PROOF_WINDOW, ValueTooHigh());

38:         for (uint256 i = 0; i < liquidationFactors.length; i++) {

42:             require(i == 0 || liquidationFactors[i] > liquidationFactors[i - 1], FactorsNotIncreasing());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/SettingsValidators.sol)

```solidity
File: ./contracts/assetManager/library/TransactionAttestation.sol

6:     from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

7: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

8: import {Globals} from "./Globals.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/TransactionAttestation.sol)

```solidity
File: ./contracts/assetManager/library/UnderlyingBalance.sol

4: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

5: import {SafePct} from "../../utils/library/SafePct.sol";

6: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

7: import {Agent} from "./data/Agent.sol";

8: import {Liquidation} from "./Liquidation.sol";

9: import {AssetManagerSettings} from "../../userInterfaces/data/AssetManagerSettings.sol";

10: import {Globals} from "./Globals.sol";

25:         int256 newBalance = _agent.underlyingBalanceUBA + _balanceChange;

43:         _agent.underlyingBalanceUBA += _balanceIncrease.toInt256().toInt128();

54:         return uint256(_agent.mintedAMG + _agent.redeemingAMG) * settings.assetMintingGranularityUBA;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/UnderlyingBalance.sol)

```solidity
File: ./contracts/assetManager/library/UnderlyingBlockUpdater.sol

4: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

5: import {AssetManagerState} from "./data/AssetManagerState.sol";

6: import {IAssetManagerEvents} from "../../userInterfaces/IAssetManagerEvents.sol";

7: import {Globals} from "./Globals.sol";

8: import {TransactionAttestation} from "./TransactionAttestation.sol";

10:     "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

39:         uint64 finalizationBlockNumber = _blockNumber + _numberOfConfirmations;

44:         uint256 finalizationBlockTimestamp = _blockTimestamp +

45:             _numberOfConfirmations * Globals.getSettings().averageBlockTimeMS / 1000;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/UnderlyingBlockUpdater.sol)

```solidity
File: ./contracts/assetManager/library/data/Agent.sol

4: import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

5: import {IICollateralPool} from "../../../collateralPool/interfaces/IICollateralPool.sol";

12:         EMPTY,              // agent does not exist

14:         LIQUIDATION,        // liquidation due to CR - ends when agent is healthy

15:         FULL_LIQUIDATION,   // illegal payment liquidation - must liquidate all and close vault

16:         DESTROYING,         // agent announced destroy, cannot mint again

17:         DESTROYED           // agent has been destroyed, cannot do anything except return info

90:         uint8 __initialLiquidationPhase; // only storage placeholder

162:         uint32 __handshakeType; // only storage placeholder

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/Agent.sol)

```solidity
File: ./contracts/assetManager/library/data/AssetManagerState.sol

4: import {RedemptionQueue} from "./RedemptionQueue.sol";

5: import {PaymentConfirmations} from "./PaymentConfirmations.sol";

6: import {UnderlyingAddressOwnership} from "./UnderlyingAddressOwnership.sol";

7: import {CollateralReservation} from "./CollateralReservation.sol";

8: import {Redemption} from "./Redemption.sol";

9: import {CollateralTypeInt} from "./CollateralTypeInt.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/AssetManagerState.sol)

```solidity
File: ./contracts/assetManager/library/data/Collateral.sol

7:         VAULT,   // vault collateral (tokens in in agent vault)

8:         POOL,           // pool collateral (NAT)

9:         AGENT_POOL      // agent's pool tokens (expressed in NAT) - only important for minting

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/Collateral.sol)

```solidity
File: ./contracts/assetManager/library/data/CollateralReservation.sol

7:         ACTIVE,         // the minting process hasn't finished yet

8:         SUCCESSFUL,     // the payment has been confirmed and the FAssets minted

9:         DEFAULTED,      // the payment has defaulted and the agent received the collateral reservation fee

10:         EXPIRED         // the confirmation time has expired and the agent called unstickMinting

26:         uint64 __handshakeStartTimestamp; // only storage placeholder

27:         bytes32 __sourceAddressesRoot; // only storage placeholder

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/CollateralReservation.sol)

```solidity
File: ./contracts/assetManager/library/data/CollateralTypeInt.sol

4: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

5: import {CollateralType} from "../../../userInterfaces/data/CollateralType.sol";

47:         uint32 __ccbMinCollateralRatioBIPS; // only storage placeholder

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/CollateralTypeInt.sol)

```solidity
File: ./contracts/assetManager/library/data/PaymentConfirmations.sol

5:     from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

16:         mapping(uint256 => bytes32) __verifiedPaymentsForDay; // only storage placeholder

18:         uint256 __verifiedPaymentsForDayStart; // only storage placeholder

82:         _state.verifiedPayments[_txKey] = _txKey; // any non-zero value is fine

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/PaymentConfirmations.sol)

```solidity
File: ./contracts/assetManager/library/data/PaymentReference.sol

7:     uint256 private constant TYPE_MASK = ((1 << 64) - 1) << TYPE_SHIFT;

8:     uint256 private constant LOW_BITS_MASK = (1 << TYPE_SHIFT) - 1;

10:     uint256 private constant MAX_ID = (1 << 64) - 1;

74:         return uint64(block.number % ID_RANDOMIZATION + 1);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/PaymentReference.sol)

```solidity
File: ./contracts/assetManager/library/data/Redemption.sol

6:         EMPTY,      // redemption request with this id doesn't exist

7:         ACTIVE,     // waiting for confirmation/default

8:         DEFAULTED,  // default called, failed or late payment can still be confirmed

10:         SUCCESSFUL, // successful payment confirmed

11:         FAILED,     // payment failed

12:         BLOCKED,    // payment blocked

13:         REJECTED    // redemption request rejected due to invalid redeemer's address

31:         uint64 __rejectionTimestamp; // only storage placeholder

32:         uint64 __takeOverTimestamp; // only storage placeholder

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/Redemption.sol)

```solidity
File: ./contracts/assetManager/library/data/RedemptionQueue.sol

21:         mapping(uint64 => Ticket) tickets;      // mapping redemption_id=>ticket

22:         mapping(address => AgentQueue) agents;  // mapping address=>dl-list

25:         uint64 newTicketId;       // increment before assigning to ticket (to avoid 0)

37:         uint64 ticketId = ++_state.newTicketId;   // pre-increment - id can never be 0

49:             assert(_state.lastTicketId == 0);    // empty queue - first and last must be 0

52:             assert(_state.lastTicketId != 0);    // non-empty queue - first and last must be non-zero

58:             assert(agent.lastTicketId == 0);    // empty queue - first and last must be 0

61:             assert(agent.lastTicketId != 0);    // non-empty queue - first and last must be non-zero

80:             assert(_ticketId == _state.firstTicketId);     // ticket is first in queue

83:             assert(_ticketId != _state.firstTicketId);     // ticket is not first in queue

87:             assert(_ticketId == _state.lastTicketId);     // ticket is last in queue

90:             assert(_ticketId != _state.lastTicketId);     // ticket is not last in queue

95:             assert(_ticketId == agent.firstTicketId);     // ticket is first in agent queue

98:             assert(_ticketId != agent.firstTicketId);     // ticket is not first in agent queue

102:             assert(_ticketId == agent.lastTicketId);     // ticket is last in agent queue

105:             assert(_ticketId != agent.lastTicketId);     // ticket is not last in agent queue

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/RedemptionQueue.sol)

```solidity
File: ./contracts/assetManager/library/data/RedemptionTimeExtension.sol

4: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

5: import {SafeMath64} from "../../../utils/library/SafeMath64.sol";

36:         uint64 accumulatedTimestamp = agentData.extendedTimestamp + state.redemptionPaymentExtensionSeconds;

38:         return agentData.extendedTimestamp - timestamp;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/RedemptionTimeExtension.sol)

```solidity
File: ./contracts/assetManager/library/data/UnderlyingAddressOwnership.sol

14:         uint64 __underlyingBlockOfEOAProof; // only storage placeholder

16:         bool __provedEOA; // only storage placeholder

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/UnderlyingAddressOwnership.sol)

```solidity
File: ./contracts/assetManagerController/implementation/AssetManagerController.sol

4: import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

5: import {Address} from "@openzeppelin/contracts/utils/Address.sol";

6: import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

8:     from "@flarenetwork/flare-periphery-contracts/flare/addressUpdater/interfaces/IIAddressUpdater.sol";

9: import {IWNat} from "../../flareSmartContracts/interfaces/IWNat.sol";

10: import {IISettingsManagement} from "../../assetManager/interfaces/IISettingsManagement.sol";

11: import {IIAssetManagerController} from "../interfaces/IIAssetManagerController.sol";

12: import {GovernedProxyImplementation} from "../../governance/implementation/GovernedProxyImplementation.sol";

13: import {AddressUpdatable} from "../../flareSmartContracts/implementation/AddressUpdatable.sol";

14: import {IIAssetManager} from "../../assetManager/interfaces/IIAssetManager.sol";

15: import {IGovernanceSettings} from "@flarenetwork/flare-periphery-contracts/flare/IGovernanceSettings.sol";

16: import {IAssetManager} from "../../userInterfaces/IAssetManager.sol";

17: import {IUUPSUpgradeable} from "../../utils/interfaces/IUUPSUpgradeable.sol";

18: import {CollateralType} from "../../userInterfaces/data/CollateralType.sol";

19: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

20: import {IGoverned} from "../../governance/interfaces/IGoverned.sol";

21: import {IAssetManagerController} from "../../userInterfaces/IAssetManagerController.sol";

22: import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";

24:     from "@flarenetwork/flare-periphery-contracts/flare/addressUpdater/interfaces/IIAddressUpdatable.sol";

25: import {IAddressUpdatable} from "../../flareSmartContracts/interfaces/IAddressUpdatable.sol";

26: import {IRedemptionTimeExtension} from "../../userInterfaces/IRedemptionTimeExtension.sol";

27: import {GovernedBase} from "../../governance/implementation/GovernedBase.sol";

85:         assetManagerIndex[address(_assetManager)] = assetManagers.length;  // 1+index, so that 0 means empty

102:         uint256 index = position - 1;   // the real index, can be 0

103:         uint256 lastIndex = assetManagers.length - 1;

106:             assetManagerIndex[address(assetManagers[index])] = index + 1;

125:         for (uint256 i = 0; i < length; i++) {

170:     function _authorizeUpgrade(address /* _newImplementation */)

715:         for (uint256 i = 0; i < _assetManagers.length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManagerController/implementation/AssetManagerController.sol)

```solidity
File: ./contracts/assetManagerController/implementation/AssetManagerControllerProxy.sol

4: import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

5: import {IGovernanceSettings} from "@flarenetwork/flare-periphery-contracts/flare/IGovernanceSettings.sol";

6: import {AssetManagerController} from "./AssetManagerController.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManagerController/implementation/AssetManagerControllerProxy.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPool.sol

4: import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";

5: import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

6: import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

7: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

8: import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

9: import {ReentrancyGuard} from "../../openzeppelin/security/ReentrancyGuard.sol";

10: import {SafePct} from "../../utils/library/SafePct.sol";

11: import {Transfers} from "../../utils/library/Transfers.sol";

12: import {MathUtils} from "../../utils/library/MathUtils.sol";

13: import {IFAsset} from "../../userInterfaces/IFAsset.sol";

14: import {IWNat} from "../../flareSmartContracts/interfaces/IWNat.sol";

15: import {IIAssetManager} from "../../assetManager/interfaces/IIAssetManager.sol";

16: import {IICollateralPool} from "../../collateralPool/interfaces/IICollateralPool.sol";

17: import {IICollateralPoolToken} from "../interfaces/IICollateralPoolToken.sol";

18: import {ICollateralPoolToken} from "../../userInterfaces/ICollateralPoolToken.sol";

19: import {IRewardManager} from "@flarenetwork/flare-periphery-contracts/flare/IRewardManager.sol";

20: import {IDistributionToDelegators} from "@flarenetwork/flare-periphery-contracts/flare/IDistributionToDelegators.sol";

21: import {ICollateralPool} from "../../userInterfaces/ICollateralPool.sol";

41:     address public agentVault;          // practically immutable because there is no setter

42:     IIAssetManager public assetManager; // practically immutable because there is no setter

43:     IFAsset public fAsset;              // practically immutable because there is no setter

44:     IICollateralPoolToken public token; // only changed once at deploy time

49:     uint32 private __topupCollateralRatioBIPS; // only storage placeholder

50:     uint16 private __topupTokenPriceFactorBIPS; // only storage placeholder

422:         if (totalCollateral == 0 || totalPoolTokens == 0) { // pool is empty

460:                 assetPrice.div * (totalCollateral - _natShare) * SafePct.MAX_BIPS / (assetPrice.mul * exitCR));

475:         return _isAboveCR(_getAssetPrice(), _agentBackedFAssets(), totalCollateral - _withdrawnNat, _safeExitCR());

488:         return _poolCollateralNat * _assetPrice.div >= (_backedFAssets * _assetPrice.mul).mulBips(_crBIPS);

516:         int256 userFees = virtualFAssetFees - accountFeeDebt;

538:         uint256 freeFassets = MathUtils.positivePart(virtualFassets.toInt256() - accountFeeDebt);

559:         int256 virtualFees = totalFAssetFees.toInt256() + totalFAssetFeeDebt;

587:         require(totalPoolTokens == _tokenShare || totalPoolTokens - _tokenShare >= MIN_TOKEN_SUPPLY_AFTER_EXIT,

596:         require(totalCollateral == _natShare || totalCollateral - _natShare >= MIN_NAT_BALANCE_AFTER_EXIT,

618:         totalFAssetFees += _amount;

626:         _fAssetFeeDebtOf[_account] += fAssets;

627:         totalFAssetFeeDebt += fAssets;

637:         _fAssetFeeDebtOf[_account] -= fAssets;

638:         totalFAssetFeeDebt -= fAssets;

649:             totalFAssetFees += _amount;

661:             totalFAssetFees -= _amount;

673:             totalCollateral -= _amount;

685:             totalCollateral -= _amount;

698:             totalCollateral += msg.value;

834:         uint256 claimed = balanceAfter - balanceBefore;

835:         totalCollateral += claimed;

853:         uint256 claimed = balanceAfter - balanceBefore;

854:         totalCollateral += claimed;

881:     function _authorizeUpgrade(address /* _newImplementation */)

884:     { // solhint-disable-line no-empty-blocks

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPool.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPoolFactory.sol

4: import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";

5: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

6: import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

7: import {IICollateralPoolFactory} from "../../collateralPool/interfaces/IICollateralPoolFactory.sol";

8: import {CollateralPool} from "./CollateralPool.sol";

9: import {IIAssetManager} from "../../assetManager/interfaces/IIAssetManager.sol";

10: import {AgentSettings} from "../../userInterfaces/data/AgentSettings.sol";

11: import {IICollateralPool} from "../../collateralPool/interfaces/IICollateralPool.sol";

41:     function upgradeInitCall(address /* _proxy */) external pure override returns (bytes memory) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPoolFactory.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPoolToken.sol

4: import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";

5: import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

6: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

8: import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

9: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

10: import {IICollateralPoolToken} from "../interfaces/IICollateralPoolToken.sol";

11: import {IICollateralPool} from "../../collateralPool/interfaces/IICollateralPool.sol";

12: import {IIAssetManager} from "../../assetManager/interfaces/IIAssetManager.sol";

13: import {ICollateralPoolToken} from "../../userInterfaces/ICollateralPoolToken.sol";

36:     address public collateralPool;  // practically immutable because there is no setter

38:     string private tokenName;       // practically immutable because there is no setter

39:     string private tokenSymbol;     // practically immutable because there is no setter

102:         _timelockExpiresAt = block.timestamp + timelockDuration;

105:             timelocks.data[timelocks.end++] = Timelock({

177:         for (uint256 i = timelocks.start; i < end; i++) {

180:                 _timelocked += timelock.amount;

195:         return balanceOf(_account) - timelockedBalanceOf(_account);

199:         address _from, address /* _to */, uint256 _amount

233:         for (uint256 count = 0; count < _maxTimelockedEntries; count++) {

237:             delete timelocks.data[start++];

274:     function _authorizeUpgrade(address /* _newImplementation */)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPoolToken.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPoolTokenFactory.sol

4: import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";

5: import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

6: import {IICollateralPoolTokenFactory} from "../../collateralPool/interfaces/IICollateralPoolTokenFactory.sol";

7: import {CollateralPoolToken} from "./CollateralPoolToken.sol";

8: import {IICollateralPool} from "../../collateralPool/interfaces/IICollateralPool.sol";

13:     string internal constant TOKEN_SYMBOL_PREFIX = "FCPT-";

25:         string memory tokenName = string.concat(TOKEN_NAME_PREFIX, _systemSuffix, "-", _agentSuffix);

26:         string memory tokenSymbol = string.concat(TOKEN_SYMBOL_PREFIX, _systemSuffix, "-", _agentSuffix);

36:     function upgradeInitCall(address /* _proxy */) external pure override returns (bytes memory) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPoolTokenFactory.sol)

```solidity
File: ./contracts/coreVaultManager/implementation/CoreVaultManager.sol

4: import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";

5: import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

6: import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

7: import {GovernedUUPSProxyImplementation} from "../../governance/implementation/GovernedUUPSProxyImplementation.sol";

8: import {AddressUpdatable} from "../../flareSmartContracts/implementation/AddressUpdatable.sol";

9: import {IICoreVaultManager} from "../interfaces/IICoreVaultManager.sol";

10: import {IFdcVerification, IPayment} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

11: import {IGovernanceSettings} from "@flarenetwork/flare-periphery-contracts/flare/IGovernanceSettings.sol";

12: import {GovernedBase} from "../../governance/implementation/GovernedBase.sol";

14:     from "@flarenetwork/flare-periphery-contracts/flare/addressUpdater/interfaces/IIAddressUpdatable.sol";

17: import {ICoreVaultManager} from "../../userInterfaces/ICoreVaultManager.sol"; // solhint-disable-line no-unused-import

49:     mapping(bytes32 preimageHash => uint256 escrowIndex) private preimageHashToEscrowIndex; // 1-based index

74:     mapping(string allowedDestinationAddress => uint256) private allowedDestinationAddressIndex; // 1-based index

157:         require(_proof.data.responseBody.status == 0, PaymentFailed()); // 0 = payment success

165:             availableFunds += receivedAmount;

193:             for (uint256 i = 0; i < cancelableTransferRequests.length; i++) {

197:             cancelableTransferRequestsAmount += _amount;

206:                     req.amount += _amount;

207:                     _paymentReference = req.paymentReference;   // use the old payment reference when merged

210:                 index++;

212:             nonCancelableTransferRequestsAmount += _amount;

221:         require(requestsAmount <= availableFunds + escrowedFunds, InsufficientFunds());

224:             transferRequestById[nextTransferRequestId++] = TransferRequest({

250:             index++;

256:         cancelableTransferRequestsAmount -= amount;

260:         while (index < cancelableTransferRequests.length - 1) { // length > 0

261:             cancelableTransferRequests[index] = cancelableTransferRequests[index + 1]; // shift left

262:             index++;

264:         cancelableTransferRequests.pop(); // remove the last element

280:         _processEscrows(type(uint256).max); // process all escrows

292:             if (availableFundsTmp >= transferRequestById[transferRequestId].amount + feeTmp) {

294:                 availableFundsTmp -= (req.amount + feeTmp);

295:                 amountTmp -= req.amount;

297:                     sequenceNumberTmp++,

304:                 _numberOfInstructions++;

306:                 for (uint256 i = index; i < length - 1; i++) { // length > 0

307:                     cancelableTransferRequests[i] = cancelableTransferRequests[i + 1]; // shift left

309:                 cancelableTransferRequests.pop(); // remove the last element

311:                 length--;

313:                 index++;

324:             if (availableFundsTmp >= transferRequestById[transferRequestId].amount + feeTmp) {

326:                 availableFundsTmp -= (req.amount + feeTmp);

327:                 amountTmp -= req.amount;

329:                     sequenceNumberTmp++,

336:                 _numberOfInstructions++;

338:                 for (uint256 i = index; i < length - 1; i++) { // length > 0

339:                     nonCancelableTransferRequests[i] = nonCancelableTransferRequests[i + 1]; // shift left

341:                 nonCancelableTransferRequests.pop(); // remove the last element

343:                 length--;

345:                 index++;

360:         uint256 minFundsToTriggerEscrow = minimalAmount + escrowAmountTmp + feeTmp;

366:                 availableFundsTmp -= (escrowAmountTmp + feeTmp);

367:                 amountTmp += escrowAmountTmp;

368:                 bytes32 preimageHash = preimageHashes.at(preimageHashIndexTmp++);

378:                     sequenceNumberTmp++,

386:                 _numberOfInstructions++;

388:                 escrowEndTimestamp += 1 days;

410:         for (uint256 i = 0; i < _allowedDestinationAddresses.length; i++) {

432:         for (uint256 i = 0; i < _allowedDestinationAddresses.length; i++) {

439:                 string memory addressToMove = allowedDestinationAddresses[length - 1];

440:                 allowedDestinationAddresses[index - 1] = addressToMove;

460:         for (uint256 i = 0; i < _triggeringAccounts.length; i++) {

478:         for (uint256 i = 0; i < _triggeringAccounts.length; i++) {

538:         for (uint256 i = 0; i < _preimageHashes.length; i++) {

558:             bytes32 preimageHash = preimageHashes.at(--index);

560:             _maxCount--;

578:         for (uint256 i = 0; i < _preimageHashes.length; i++) {

584:                 availableFundsTmp -= escrow.amount;

586:                 escrowedFundsTmp -= escrow.amount;

603:         for (uint256 i = 0; i < _addresses.length; i++) {

619:         for (uint256 i = 0; i < _addresses.length; i++) {

651:             nextSequenceNumber++,

697:         uint256 length = escrows.length - nextUnprocessedEscrowIndex;

699:         for (uint256 i = 0; i < length; i++) {

700:             _unprocessedEscrows[i] = escrows[nextUnprocessedEscrowIndex + i];

730:         uint256 length = preimageHashes.length() - nextUnusedPreimageHashIndex;

732:         for (uint256 i = 0; i < length; i++) {

733:             unusedPreimageHashes[i] = preimageHashes.at(nextUnusedPreimageHashIndex + i);

757:         for (uint256 i = 0; i < cancelableTransferRequests.length; i++) {

767:         for (uint256 i = 0; i < nonCancelableTransferRequests.length; i++) {

776:         return nonCancelableTransferRequestsAmount + cancelableTransferRequestsAmount +

777:             (cancelableTransferRequests.length + nonCancelableTransferRequests.length) * fee;

832:                 availableFundsTmp += amount;

833:                 escrowedFundsTmp -= amount;

836:             index++;

837:             _maxCount--;

858:         return escrows[_index - 1];

868:         for (uint256 i = escrows.length; i > nextUnprocessedEscrowIndex; i--) {

869:             if (!escrows[i - 1].finished) {

870:                 escrowEndTimestamp = escrows[i - 1].expiryTs;

875:         escrowEndTimestamp += 1 days;

877:         escrowEndTimestamp = escrowEndTimestamp - (escrowEndTimestamp % 1 days) + escrowEndTimeSeconds;

878:         if (escrowEndTimestamp <= block.timestamp + 12 hours) { // less than 12 hours from now, move to the next day

879:             escrowEndTimestamp += 1 days;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/coreVaultManager/implementation/CoreVaultManager.sol)

```solidity
File: ./contracts/coreVaultManager/implementation/CoreVaultManagerProxy.sol

4: import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

5: import {IGovernanceSettings} from "@flarenetwork/flare-periphery-contracts/flare/IGovernanceSettings.sol";

6: import {CoreVaultManager} from "./CoreVaultManager.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/coreVaultManager/implementation/CoreVaultManagerProxy.sol)

```solidity
File: ./contracts/diamond/facets/DiamondLoupeFacet.sol

11: import { IERC165 } from "@openzeppelin/contracts/utils/introspection/IERC165.sol";

12: import { IDiamondLoupe } from "../interfaces/IDiamondLoupe.sol";

13: import { LibDiamond } from  "../library/LibDiamond.sol";

41:         for (uint256 selectorIndex; selectorIndex < selectorCount; selectorIndex++) {

46:             for (uint256 facetIndex; facetIndex < numFacets; facetIndex++) {

49:                     numFacetSelectors[facetIndex]++;

64:             numFacets++;

66:         for (uint256 facetIndex; facetIndex < numFacets; facetIndex++) {

92:         for (uint256 selectorIndex; selectorIndex < selectorCount; selectorIndex++) {

97:                 numSelectors++;

118:         for (uint256 selectorIndex; selectorIndex < selectorCount; selectorIndex++) {

123:             for (uint256 facetIndex; facetIndex < numFacets; facetIndex++) {

136:             numFacets++;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/diamond/facets/DiamondLoupeFacet.sol)

```solidity
File: ./contracts/diamond/implementation/Diamond.sol

11: import { LibDiamond } from "../library/LibDiamond.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/diamond/implementation/Diamond.sol)

```solidity
File: ./contracts/diamond/library/LibDiamond.sol

8: import { IDiamond } from "../interfaces/IDiamond.sol";

9: import { IDiamondCut } from "../interfaces/IDiamondCut.sol";

61:         for (uint256 facetIndex; facetIndex < _diamondCut.length; facetIndex++) {

89:         for (uint256 selectorIndex; selectorIndex < _functionSelectors.length; selectorIndex++) {

98:             selectorCount++;

108:         for (uint256 selectorIndex; selectorIndex < _functionSelectors.length; selectorIndex++) {

132:         for (uint256 selectorIndex; selectorIndex < _functionSelectors.length; selectorIndex++) {

145:             selectorCount--;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/diamond/library/LibDiamond.sol)

```solidity
File: ./contracts/fassetToken/implementation/CheckPointable.sol

4: import {IICheckPointable} from "../interfaces/IICheckPointable.sol";

5: import {CheckPointHistory} from "../library/CheckPointHistory.sol";

6: import {CheckPointsByAddress} from "../library/CheckPointsByAddress.sol";

77:         uint256 newBalance = balanceOfAt(_owner, block.number) - _amount;

80:         totalSupply.writeValue(totalSupplyAt(block.number) - _amount);

90:         uint256 newBalance = balanceOfAt(_owner, block.number) + _amount;

93:         totalSupply.writeValue(totalSupplyAt(block.number) + _amount);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/implementation/CheckPointable.sol)

```solidity
File: ./contracts/fassetToken/implementation/FAsset.sol

4: import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

5: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

6: import {IERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol";

7: import {IERC20Metadata} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

8: import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";

9: import {IERC5267} from "@openzeppelin/contracts/interfaces/IERC5267.sol";

10: import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

11: import {IIFAsset} from "../interfaces/IIFAsset.sol";

12: import {ERC20Permit} from "../../openzeppelin/token/ERC20Permit.sol";

13: import {CheckPointable} from "./CheckPointable.sol";

14: import {IAssetManager} from "../../userInterfaces/IAssetManager.sol";

15: import {IICleanable} from "@flarenetwork/flare-periphery-contracts/flare/token/interfaces/IICleanable.sol";

16: import {IFAsset} from "../../userInterfaces/IFAsset.sol";

17: import {IICheckPointable} from "../interfaces/IICheckPointable.sol";

55:     uint64 private __terminatedAt; // only storage placeholder

252:     function _authorizeUpgrade(address /* _newImplementation */)

255:     { // solhint-disable-line no-empty-blocks

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/implementation/FAsset.sol)

```solidity
File: ./contracts/fassetToken/implementation/FAssetProxy.sol

4: import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

5: import {FAsset} from "./FAsset.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/implementation/FAssetProxy.sol)

```solidity
File: ./contracts/fassetToken/library/CheckPointHistory.sol

4: import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

5: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

59:         uint256 max = _endIndex - 1;

61:             uint256 mid = (max + min + 1) / 2;

65:                 max = mid - 1;

91:         if (_blockNumber >= block.number || _blockNumber >= _self.checkpoints[historyCount - 1].fromBlock) {

92:             return _self.checkpoints[historyCount - 1].value;

119:         return _self.checkpoints[historyCount - 1].value;

141:             CheckPoint storage lastCheckpoint = _self.checkpoints[historyCount - 1];

153:                 _self.endIndex = uint64(historyCount + 1);  // 64 bit safe, because historyCount <= block.number

171:         if (_cleanupBlockNumber == 0) return 0;   // optimization for when cleaning is not enabled

176:         uint256 endIndex = Math.min(startIndex + _count, length - 1);    // last element can never be deleted

179:         while (index < endIndex && _self.checkpoints[index + 1].fromBlock <= _cleanupBlockNumber) {

181:             index++;

183:         if (index > startIndex) {   // index is the first not deleted index

186:         return index - startIndex;  // safe: index >= startIndex at start and then increases

191:         require(_value < 2**192, ValueDoesNotFitInOneNineTwoBits());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/library/CheckPointHistory.sol)

```solidity
File: ./contracts/fassetToken/library/CheckPointsByAddress.sol

4: import {CheckPointHistory} from "./CheckPointHistory.sol";

45:             uint256 newValueFrom = valueOfAtNow(_self, _from) - _amount;

52:             uint256 newValueTo = valueOfAtNow(_self, _to) + _amount;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/library/CheckPointsByAddress.sol)

```solidity
File: ./contracts/flareSmartContracts/implementation/AddressUpdatable.sol

5:     from "@flarenetwork/flare-periphery-contracts/flare/addressUpdater/interfaces/IIAddressUpdatable.sol";

6: import {IAddressUpdatable} from "../interfaces/IAddressUpdatable.sol";

72:         for (uint256 i = 0; i < _nameHashes.length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/flareSmartContracts/implementation/AddressUpdatable.sol)

```solidity
File: ./contracts/ftso/implementation/FtsoV2PriceStore.sol

4: import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";

5: import {MerkleProof} from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

6: import {IRelay} from "@flarenetwork/flare-periphery-contracts/flare/IRelay.sol";

7: import {GovernedUUPSProxyImplementation} from "../../governance/implementation/GovernedUUPSProxyImplementation.sol";

8: import {AddressUpdatable} from "../../flareSmartContracts/implementation/AddressUpdatable.sol";

9: import {IPriceReader} from "../../ftso/interfaces/IPriceReader.sol";

10: import {IPricePublisher} from "../interfaces/IPricePublisher.sol";

11: import {IGovernanceSettings} from "@flarenetwork/flare-periphery-contracts/flare/IGovernanceSettings.sol";

94:         GovernedUUPSProxyImplementation()   // marks as initialized

108:         require(_firstVotingRoundStartTs + _votingEpochDurationSeconds <= block.timestamp, InvalidStartTime());

109:         require(_votingEpochDurationSeconds > 1, VotingEpochDurationTooShort()); // 90 s

111:         initialise(_governanceSettings, _initialGovernance);    // also marks as initialized

115:         submitTrustedPricesWindowSeconds = _votingEpochDurationSeconds / 2; // 45 s

126:         for (uint256 i = 0; i < _proofs.length; i++) {

132:                 require(_getEndTimestamp(votingRoundId) + submitTrustedPricesWindowSeconds <= block.timestamp,

156:             if (trustedPrices.length > 0 && trustedPrices.length >= 4 * trustedProvidersThreshold) {

163:                     priceStore.numberOfSubmits = uint8(trustedPrices.length / 4);

182:         uint256 endTimestamp = startTimestamp + submitTrustedPricesWindowSeconds;

188:         for (uint256 i = 0; i < _feeds.length; i++) {

218:         for (uint256 i = 0; i < _feedIds.length; i++) {

228:                 for (uint32 j = lastPublishedVotingRoundId + 1; j <= _getPreviousVotingEpochId(); j++) {

247:         require(_trustedProviders.length < 2**8, TooManyTrustedProviders());

251:         for (uint256 i = 0; i < trustedProviders.length; i++) {

256:         for (uint256 i = 0; i < _trustedProviders.length; i++) {

273:         int256 decimals = feed.decimals; // int8

276:             _price *= 10 ** uint256(-decimals);

322:         for (uint256 i = 0; i < _feedIds.length; i++) {

332:         for (uint256 i = 0; i < feedIds.length; i++) {

367:         return uint32((block.timestamp - firstVotingRoundStartTs) / votingEpochDurationSeconds) - 1;

374:         return firstVotingRoundStartTs + (_votingEpochId + 1) * votingEpochDurationSeconds;

386:         int256 decimals = _feed.trustedDecimals; // int8

389:             _price *= 10 ** uint256(-decimals);

404:         length /= 4;

406:         for (uint256 i = 0; i < length; i++) {

408:             for (uint256 j = 0; j < 4; j++) {

409:                 price[j] = _prices[i * 4 + j];

414:         for (uint256 i = 1; i < length; i++) {

420:             while (j > 0 && prices[j - 1] > currentPrice) {

421:                 prices[j] = prices[j - 1];

422:                 j--; // no underflow

429:         uint256 middleIndex = length / 2;

433:                 spread = (prices[middleIndex + 1] - prices[middleIndex - 1]) / 2;

437:             _medianPrice = (prices[middleIndex - 1] + prices[middleIndex]) / 2;

438:             spread = prices[middleIndex] - prices[middleIndex - 1];

441:         _priceOk = spread <= maxSpreadBIPS * _medianPrice / MAX_BIPS; // no overflow

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/ftso/implementation/FtsoV2PriceStore.sol)

```solidity
File: ./contracts/ftso/implementation/FtsoV2PriceStoreProxy.sol

4: import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

5: import {IGovernanceSettings} from "@flarenetwork/flare-periphery-contracts/flare/IGovernanceSettings.sol";

6: import {FtsoV2PriceStore} from "./FtsoV2PriceStore.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/ftso/implementation/FtsoV2PriceStoreProxy.sol)

```solidity
File: ./contracts/governance/implementation/Governed.sol

4: import { GovernedBase } from "./GovernedBase.sol";

5: import { IGovernanceSettings } from "@flarenetwork/flare-periphery-contracts/flare/IGovernanceSettings.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/governance/implementation/Governed.sol)

```solidity
File: ./contracts/governance/implementation/GovernedBase.sol

4: import {IGovernanceSettings} from "@flarenetwork/flare-periphery-contracts/flare/IGovernanceSettings.sol";

5: import {IGoverned} from "../interfaces/IGoverned.sol";

167:         uint256 allowedAt = block.timestamp + timelock;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/governance/implementation/GovernedBase.sol)

```solidity
File: ./contracts/governance/implementation/GovernedProxyImplementation.sol

4: import { IGovernanceSettings, GovernedBase } from "./GovernedBase.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/governance/implementation/GovernedProxyImplementation.sol)

```solidity
File: ./contracts/governance/implementation/GovernedUUPSProxyImplementation.sol

4: import { UUPSUpgradeable } from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

5: import { GovernedProxyImplementation } from "./GovernedProxyImplementation.sol";

6: import { IUUPSUpgradeable } from "../../utils/interfaces/IUUPSUpgradeable.sol";

46:     function _authorizeUpgrade(address  /* _newImplementation */)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/governance/implementation/GovernedUUPSProxyImplementation.sol)

```solidity
File: ./contracts/userInterfaces/IAgentVault.sol

5: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

6: import {ICollateralPool} from "./ICollateralPool.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAgentVault.sol)

```solidity
File: ./contracts/userInterfaces/IAssetManager.sol

6:     from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

7: import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";

8: import {IDiamondLoupe} from "../diamond/interfaces/IDiamondLoupe.sol";

9: import {AssetManagerSettings} from "./data/AssetManagerSettings.sol";

10: import {CollateralType} from "./data/CollateralType.sol";

11: import {AgentInfo} from "./data/AgentInfo.sol";

12: import {AgentSettings} from "./data/AgentSettings.sol";

13: import {AvailableAgentInfo} from "./data/AvailableAgentInfo.sol";

14: import {RedemptionTicketInfo} from "./data/RedemptionTicketInfo.sol";

15: import {RedemptionRequestInfo} from "./data/RedemptionRequestInfo.sol";

16: import {CollateralReservationInfo} from "./data/CollateralReservationInfo.sol";

17: import {IAssetManagerEvents} from "./IAssetManagerEvents.sol";

18: import {IAgentPing} from "./IAgentPing.sol";

19: import {IRedemptionTimeExtension} from "./IRedemptionTimeExtension.sol";

20: import {ICoreVaultClient} from "./ICoreVaultClient.sol";

21: import {ICoreVaultClientSettings} from "./ICoreVaultClientSettings.sol";

22: import {IAgentAlwaysAllowedMinters} from "./IAgentAlwaysAllowedMinters.sol";

23: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAssetManager.sol)

```solidity
File: ./contracts/userInterfaces/IAssetManagerController.sol

4: import {IAssetManager} from "./IAssetManager.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAssetManagerController.sol)

```solidity
File: ./contracts/userInterfaces/ICollateralPool.sol

5: import {IDistributionToDelegators} from "@flarenetwork/flare-periphery-contracts/flare/IDistributionToDelegators.sol";

6: import {IRewardManager} from "@flarenetwork/flare-periphery-contracts/flare/IRewardManager.sol";

7: import {ICollateralPoolToken} from "./ICollateralPoolToken.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/ICollateralPool.sol)

```solidity
File: ./contracts/userInterfaces/ICollateralPoolToken.sol

5: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/ICollateralPoolToken.sol)

```solidity
File: ./contracts/userInterfaces/ICoreVaultClient.sol

4: import {IPayment} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/ICoreVaultClient.sol)

```solidity
File: ./contracts/userInterfaces/ICoreVaultManager.sol

4: import {IPayment} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/ICoreVaultManager.sol)

```solidity
File: ./contracts/userInterfaces/IFAsset.sol

4: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

5: import {IERC20Metadata} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IFAsset.sol)

```solidity
File: ./contracts/userInterfaces/data/AgentInfo.sol

4: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/AgentInfo.sol)

```solidity
File: ./contracts/userInterfaces/data/AgentSettings.sol

4: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/AgentSettings.sol)

```solidity
File: ./contracts/userInterfaces/data/AssetManagerSettings.sol

42:         address __whitelist; // only storage placeholder

109:         uint16 __minUnderlyingBackingBIPS; // only storage placeholder

114:         bool __requireEOAAddressProof; // only storage placeholder

151:         uint32 __redemptionDefaultFactorPoolBIPS; // only storage placeholder

191:         uint64 __ccbTimeSeconds; // only storage placeholder

206:         uint64 __buybackCollateralFactorBIPS; // only storage placeholder

284:         uint64 __cancelCollateralReservationAfterSeconds; // only storage placeholder

289:         uint16 __rejectOrCancelCollateralReservationReturnFactorBIPS; // only storage placeholder

293:         uint64 __rejectRedemptionRequestWindowSeconds; // only storage placeholder

298:         uint64 __takeOverRedemptionRequestWindowSeconds; // only storage placeholder

305:         uint32 __rejectedRedemptionDefaultFactorVaultCollateralBIPS; // only storage placeholder

309:         uint32 __rejectedRedemptionDefaultFactorPoolBIPS; // only storage placeholder

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/AssetManagerSettings.sol)

```solidity
File: ./contracts/userInterfaces/data/AvailableAgentInfo.sol

4: import {AgentInfo} from "./AgentInfo.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/AvailableAgentInfo.sol)

```solidity
File: ./contracts/userInterfaces/data/CollateralReservationInfo.sol

7:         ACTIVE,         // the minting process hasn't finished yet

8:         SUCCESSFUL,     // the payment has been confirmed and the FAssets minted

9:         DEFAULTED,      // the payment has defaulted and the agent received the collateral reservation fee

10:         EXPIRED         // the confirmation time has expired and the agent called unstickMinting

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/CollateralReservationInfo.sol)

```solidity
File: ./contracts/userInterfaces/data/CollateralType.sol

4: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

9:         NONE,   // unused

10:         POOL,   // pool collateral type

11:         VAULT  // usable as vault collateral

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/CollateralType.sol)

```solidity
File: ./contracts/userInterfaces/data/RedemptionRequestInfo.sol

7:         ACTIVE,                 // waiting for confirmation/default

8:         DEFAULTED_UNCONFIRMED,  // default called, failed or late payment can still be confirmed

10:         SUCCESSFUL,             // successful payment confirmed

11:         DEFAULTED_FAILED,       // payment failed   (default was paid)

12:         BLOCKED,                // payment blocked

13:         REJECTED                // redemption request rejected due to invalid redeemer's address

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/RedemptionRequestInfo.sol)

```solidity
File: ./contracts/utils/Imports_Solidity_0_6.sol

8: import {MockContract} from "@gnosis.pm/mock-contract/contracts/MockContract.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/utils/Imports_Solidity_0_6.sol)

```solidity
File: ./contracts/utils/library/MathUtils.sol

11:         return remainder == 0 ? x : x - remainder + rounding;

18:         return _a > _b ? _a - _b : 0;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/utils/library/MathUtils.sol)

```solidity
File: ./contracts/utils/library/MerkleTree.sol

44:             state.logN++;

45:             state.n /= 2;

51:         bytes32[] memory hashStack = new bytes32[](state.logN + 1);

52:         uint256[] memory levelStack = new uint256[](state.logN + 1);

61:         uint256 leftStart = (1 << state.logN) - (state.n % (1 << state.logN));

74:         for (uint256 initialLevel = 0; initialLevel < 2; initialLevel++) {

87:                     levelStack[stackTop - 1] == levelStack[stackTop - 2])

92:                     levelStack[stackTop - 1] == levelStack[stackTop - 2]

95:                     if (hashStack[stackTop - 1] < hashStack[stackTop - 2]) {

96:                         (hashStack[stackTop - 1], hashStack[stackTop - 2]) =

97:                             (hashStack[stackTop - 2], hashStack[stackTop - 1]);

113:                     levelStack[stackTop - 2]++;

114:                     stackTop--;

121:                     stackTop++;

122:                     arrayPtr++;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/utils/library/MerkleTree.sol)

```solidity
File: ./contracts/utils/library/SafePct.sol

29:             uint256 xy = x * y;

30:             if (xy / x == y) { // no overflow happened (works in unchecked)

31:                 return xy / z;

36:         uint256 a = x / z;

37:         uint256 b = x % z; // x = a * z + b

40:         uint256 c = y / z;

41:         uint256 d = y % z; // y = c * z + d

43:         return (a * c * z) + (a * d) + (b * c) + (b * d / z);

55:             return remainder == 0 ? resultRoundDown : resultRoundDown + 1;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/utils/library/SafePct.sol)

```solidity
File: ./contracts/utils/library/Transfers.sol

4: import {IWNat} from "../../flareSmartContracts/interfaces/IWNat.sol";

5: import {Reentrancy} from "../../openzeppelin/library/Reentrancy.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/utils/library/Transfers.sol)

### <a name="GAS-6"></a>[GAS-6] Use Custom Errors instead of Revert Strings to save Gas
Custom errors are available from solidity version 0.8.4. Custom errors save [**~50 gas**](https://gist.github.com/IllIllI000/ad1bd0d29a0101b25e57c293b4b0c746) each time they're hit by [avoiding having to allocate and store the revert string](https://blog.soliditylang.org/2021/04/21/custom-errors/#errors-in-depth). Not defining the strings also save deployment gas

Additionally, custom errors can be used inside and outside of contracts (including interfaces and libraries).

Source: <https://blog.soliditylang.org/2021/04/21/custom-errors/>:

> Starting from [Solidity v0.8.4](https://github.com/ethereum/solidity/releases/tag/v0.8.4), there is a convenient and gas-efficient way to explain to users why an operation failed through the use of custom errors. Until now, you could already use strings to give more information about failures (e.g., `revert("Insufficient funds.");`), but they are rather expensive, especially when it comes to deploy cost, and it is difficult to use dynamic information in them.

Consider replacing **all revert strings** with custom errors in the solution, and particularly those that have multiple occurrences:

*Instances (1)*:
```solidity
File: ./contracts/assetManager/facets/AgentVaultManagementFacet.sol

297:             require((ch >= "A" && ch <= "Z") || (ch >= "0" && ch <= "9") || (i > 0 && i < len - 1 && ch == "-"),

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentVaultManagementFacet.sol)

### <a name="GAS-7"></a>[GAS-7] Avoid contract existence checks by using low level calls
Prior to 0.8.10 the compiler inserted extra code, including `EXTCODESIZE` (**100 gas**), to check for contract existence for external function calls. In more recent solidity versions, the compiler will not insert these checks if the external call has a return value. Similar behavior can be achieved in earlier versions by using low-level calls, since low level calls never check for contract existence

*Instances (19)*:
```solidity
File: ./contracts/assetManager/library/AgentCollateral.sol

61:             fullCollateral: collateral.token.balanceOf(_agent.vaultAddress()),

88:         uint256 agentPoolTokens = poolToken.balanceOf(_agent.vaultAddress());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/AgentCollateral.sol)

```solidity
File: ./contracts/assetManager/library/AgentPayout.sol

27:         _amountPaid = Math.min(_amountWei, collateral.token.balanceOf(address(vault)));

42:         _amountPaid = Math.min(_amountWei, collateral.token.balanceOf(address(vault)));

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/AgentPayout.sol)

```solidity
File: ./contracts/assetManager/library/Liquidation.sol

180:             return collateral.token.balanceOf(_agent.vaultAddress());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Liquidation.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPool.sol

194:         require(_tokenShare <= token.balanceOf(msg.sender), TokenBalanceTooLow());

278:         require(_tokenShare <= token.balanceOf(msg.sender), TokenBalanceTooLow());

401:         uint256 agentTokenBalance = token.balanceOf(agentVault);

504:         uint256 tokens = token.balanceOf(_account);

534:             return token.balanceOf(_account);

748:         return MathUtils.subOrZero(token.balanceOf(_account), _debtFreeTokensOf(_account));

774:         uint256 untrackedWNat = wNat.balanceOf(address(this));

775:         uint256 untrackedFAsset = fAsset.balanceOf(address(this));

792:         uint256 balance = wNat.balanceOf(address(this));

831:         uint256 balanceBefore = wNat.balanceOf(address(this));

833:         uint256 balanceAfter = wNat.balanceOf(address(this));

850:         uint256 balanceBefore = wNat.balanceOf(address(this));

852:         uint256 balanceAfter = wNat.balanceOf(address(this));

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPool.sol)

```solidity
File: ./contracts/diamond/library/LibDiamond.sol

164:         (bool success, bytes memory error) = _init.delegatecall(_calldata);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/diamond/library/LibDiamond.sol)

### <a name="GAS-8"></a>[GAS-8] Functions guaranteed to revert when called by normal users can be marked `payable`
If a function modifier such as `onlyOwner` is used, the function will revert if a normal user tries to pay the function. Marking the function as `payable` will lower the gas cost for legitimate callers because the compiler will not include checks for whether a payment was provided.

*Instances (12)*:
```solidity
File: ./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistry.sol

42:     function revokeAddress(address _address) external onlyGovernanceOrManager {

46:     function setManager(address _manager) external onlyGovernance {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistry.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPool.sol

805:     function delegate(address _to, uint256 _bips) external onlyAgent {

809:     function undelegateAll() external onlyAgent {

813:     function delegateGovernance(address _to) external onlyAgent {

817:     function undelegateGovernance() external onlyAgent {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPool.sol)

```solidity
File: ./contracts/coreVaultManager/implementation/CoreVaultManager.sol

639:     function unpause() external onlyImmediateGovernance {

649:     function triggerCustomInstructions(bytes32 _instructionsHash) external onlyImmediateGovernance {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/coreVaultManager/implementation/CoreVaultManager.sol)

```solidity
File: ./contracts/fassetToken/implementation/CheckPointable.sol

173:     function balanceHistoryCleanup(address _owner, uint256 _count) external onlyCleaner returns (uint256) {

183:     function totalSupplyHistoryCleanup(uint256 _count) external onlyCleaner returns (uint256) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/implementation/CheckPointable.sol)

```solidity
File: ./contracts/governance/implementation/GovernedBase.sol

80:     function cancelGovernanceCall(bytes calldata _encodedCall) external override onlyImmediateGovernance {

93:     function switchToProductionMode() external onlyImmediateGovernance {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/governance/implementation/GovernedBase.sol)

### <a name="GAS-9"></a>[GAS-9] `++i` costs less gas compared to `i++` or `i += 1` (same for `--i` vs `i--` or `i -= 1`)
Pre-increments and pre-decrements are cheaper.

For a `uint256 i` variable, the following is true with the Optimizer enabled at 10k:

**Increment:**

- `i += 1` is the most expensive form
- `i++` costs 6 gas less than `i += 1`
- `++i` costs 5 gas less than `i++` (11 gas less than `i += 1`)

**Decrement:**

- `i -= 1` is the most expensive form
- `i--` costs 11 gas less than `i -= 1`
- `--i` costs 5 gas less than `i--` (16 gas less than `i -= 1`)

Note that post-increments (or post-decrements) return the old value before incrementing or decrementing, hence the name *post-increment*:

```solidity
uint i = 1;
uint j = 2;
require(j == i++, "This will be false as i is incremented after the comparison");
```

However, pre-increments (or pre-decrements) return the new value:

```solidity
uint i = 1;
uint j = 2;
require(j == ++i, "This will be true as i is incremented before the comparison");
```

In the pre-increment case, the compiler has to create a temporary variable (when used) for returning `1` instead of `2`.

Consider using pre-increments and pre-decrements where they are relevant (meaning: not where post-increments/decrements logic are relevant).

*Saves 5 gas per instance*

*Instances (88)*:
```solidity
File: ./contracts/assetManager/facets/AgentVaultManagementFacet.sol

225:         for (uint256 i = 0; i < _agents.length; i++) {

294:         for (uint256 i = 0; i < len; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentVaultManagementFacet.sol)

```solidity
File: ./contracts/assetManager/facets/AvailableAgentsFacet.sol

127:         for (uint256 i = _start; i < _end; i++) {

153:         for (uint256 i = _start; i < _end; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AvailableAgentsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/ChallengesFacet.sol

155:         for (uint256 i = 0; i < _payments.length; i++) {

159:             for (uint256 j = 0; j < i; j++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/ChallengesFacet.sol)

```solidity
File: ./contracts/assetManager/facets/RedemptionRequestsFacet.sol

74:         for (uint256 i = 0; i < maxRedeemedTickets && redeemedLots < _lots; i++) {

84:         for (uint256 i = 0; i < redemptionList.length; i++) {

178:         for (uint256 i = 0; ticketId != 0 && i < maxRedeemedTickets; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/RedemptionRequestsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/SettingsManagementFacet.sol

568:         for (uint256 i = 0; i < _liquidationFactors.length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/SettingsManagementFacet.sol)

```solidity
File: ./contracts/assetManager/library/Agents.sol

41:         for (uint256 i = _start; i < _end; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Agents.sol)

```solidity
File: ./contracts/assetManager/library/CollateralTypes.sol

38:         for (uint256 i = 1; i < _data.length; i++) {

80:         for (uint256 i = 0; i < length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/CollateralTypes.sol)

```solidity
File: ./contracts/assetManager/library/Redemptions.sol

34:         for (uint256 i = 0; i < maxRedeemedTickets && _closedAMG < _amountAMG; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Redemptions.sol)

```solidity
File: ./contracts/assetManager/library/SettingsValidators.sol

38:         for (uint256 i = 0; i < liquidationFactors.length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/SettingsValidators.sol)

```solidity
File: ./contracts/assetManagerController/implementation/AssetManagerController.sol

125:         for (uint256 i = 0; i < length; i++) {

715:         for (uint256 i = 0; i < _assetManagers.length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManagerController/implementation/AssetManagerController.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPoolToken.sol

177:         for (uint256 i = timelocks.start; i < end; i++) {

233:         for (uint256 count = 0; count < _maxTimelockedEntries; count++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPoolToken.sol)

```solidity
File: ./contracts/coreVaultManager/implementation/CoreVaultManager.sol

193:             for (uint256 i = 0; i < cancelableTransferRequests.length; i++) {

210:                 index++;

250:             index++;

262:             index++;

297:                     sequenceNumberTmp++,

304:                 _numberOfInstructions++;

306:                 for (uint256 i = index; i < length - 1; i++) { // length > 0

311:                 length--;

313:                 index++;

329:                     sequenceNumberTmp++,

336:                 _numberOfInstructions++;

338:                 for (uint256 i = index; i < length - 1; i++) { // length > 0

343:                 length--;

345:                 index++;

368:                 bytes32 preimageHash = preimageHashes.at(preimageHashIndexTmp++);

378:                     sequenceNumberTmp++,

386:                 _numberOfInstructions++;

410:         for (uint256 i = 0; i < _allowedDestinationAddresses.length; i++) {

432:         for (uint256 i = 0; i < _allowedDestinationAddresses.length; i++) {

460:         for (uint256 i = 0; i < _triggeringAccounts.length; i++) {

478:         for (uint256 i = 0; i < _triggeringAccounts.length; i++) {

538:         for (uint256 i = 0; i < _preimageHashes.length; i++) {

558:             bytes32 preimageHash = preimageHashes.at(--index);

560:             _maxCount--;

578:         for (uint256 i = 0; i < _preimageHashes.length; i++) {

603:         for (uint256 i = 0; i < _addresses.length; i++) {

619:         for (uint256 i = 0; i < _addresses.length; i++) {

651:             nextSequenceNumber++,

699:         for (uint256 i = 0; i < length; i++) {

732:         for (uint256 i = 0; i < length; i++) {

757:         for (uint256 i = 0; i < cancelableTransferRequests.length; i++) {

767:         for (uint256 i = 0; i < nonCancelableTransferRequests.length; i++) {

836:             index++;

837:             _maxCount--;

868:         for (uint256 i = escrows.length; i > nextUnprocessedEscrowIndex; i--) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/coreVaultManager/implementation/CoreVaultManager.sol)

```solidity
File: ./contracts/diamond/facets/DiamondLoupeFacet.sol

41:         for (uint256 selectorIndex; selectorIndex < selectorCount; selectorIndex++) {

46:             for (uint256 facetIndex; facetIndex < numFacets; facetIndex++) {

64:             numFacets++;

66:         for (uint256 facetIndex; facetIndex < numFacets; facetIndex++) {

92:         for (uint256 selectorIndex; selectorIndex < selectorCount; selectorIndex++) {

97:                 numSelectors++;

118:         for (uint256 selectorIndex; selectorIndex < selectorCount; selectorIndex++) {

123:             for (uint256 facetIndex; facetIndex < numFacets; facetIndex++) {

136:             numFacets++;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/diamond/facets/DiamondLoupeFacet.sol)

```solidity
File: ./contracts/diamond/library/LibDiamond.sol

61:         for (uint256 facetIndex; facetIndex < _diamondCut.length; facetIndex++) {

89:         for (uint256 selectorIndex; selectorIndex < _functionSelectors.length; selectorIndex++) {

98:             selectorCount++;

108:         for (uint256 selectorIndex; selectorIndex < _functionSelectors.length; selectorIndex++) {

132:         for (uint256 selectorIndex; selectorIndex < _functionSelectors.length; selectorIndex++) {

145:             selectorCount--;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/diamond/library/LibDiamond.sol)

```solidity
File: ./contracts/fassetToken/library/CheckPointHistory.sol

181:             index++;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/library/CheckPointHistory.sol)

```solidity
File: ./contracts/flareSmartContracts/implementation/AddressUpdatable.sol

72:         for (uint256 i = 0; i < _nameHashes.length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/flareSmartContracts/implementation/AddressUpdatable.sol)

```solidity
File: ./contracts/ftso/implementation/FtsoV2PriceStore.sol

126:         for (uint256 i = 0; i < _proofs.length; i++) {

188:         for (uint256 i = 0; i < _feeds.length; i++) {

218:         for (uint256 i = 0; i < _feedIds.length; i++) {

228:                 for (uint32 j = lastPublishedVotingRoundId + 1; j <= _getPreviousVotingEpochId(); j++) {

251:         for (uint256 i = 0; i < trustedProviders.length; i++) {

256:         for (uint256 i = 0; i < _trustedProviders.length; i++) {

322:         for (uint256 i = 0; i < _feedIds.length; i++) {

332:         for (uint256 i = 0; i < feedIds.length; i++) {

406:         for (uint256 i = 0; i < length; i++) {

408:             for (uint256 j = 0; j < 4; j++) {

414:         for (uint256 i = 1; i < length; i++) {

422:                 j--; // no underflow

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/ftso/implementation/FtsoV2PriceStore.sol)

```solidity
File: ./contracts/utils/library/MerkleTree.sol

44:             state.logN++;

74:         for (uint256 initialLevel = 0; initialLevel < 2; initialLevel++) {

114:                     stackTop--;

121:                     stackTop++;

122:                     arrayPtr++;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/utils/library/MerkleTree.sol)

### <a name="GAS-10"></a>[GAS-10] Using `private` rather than `public` for constants, saves gas
If needed, the values can be read from the verified contract source code, or if there are multiple values there can be a single getter function that [returns a tuple](https://github.com/code-423n4/2022-08-frax/blob/90f55a9ce4e25bceed3a74290b854341d8de6afa/src/contracts/FraxlendPair.sol#L156-L178) of the values of all currently-public constants. Saves **3406-3606 gas** in deployment gas due to the compiler not having to create non-payable getter functions for deployment calldata, not having to store the bytes of the value outside of where it's used, and not adding another entry to the method ID table

*Instances (3)*:
```solidity
File: ./contracts/collateralPool/implementation/CollateralPool.sol

37:     uint256 public constant MIN_NAT_TO_ENTER = 1 ether;

38:     uint256 public constant MIN_TOKEN_SUPPLY_AFTER_EXIT = 1 ether;

39:     uint256 public constant MIN_NAT_BALANCE_AFTER_EXIT = 1 ether;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPool.sol)

### <a name="GAS-11"></a>[GAS-11] Use shift right/left instead of division/multiplication if possible
While the `DIV` / `MUL` opcode uses 5 gas, the `SHR` / `SHL` opcode only uses 3 gas. Furthermore, beware that Solidity's division operation also includes a division-by-0 prevention which is bypassed using shifting. Eventually, overflow checks are never performed for shift operations as they are done for arithmetic operations. Instead, the result is always truncated, so the calculation can be unchecked in Solidity version `0.8+`
- Use `>> 1` instead of `/ 2`
- Use `>> 2` instead of `/ 4`
- Use `<< 3` instead of `* 8`
- ...
- Use `>> 5` instead of `/ 2^5 == / 32`
- Use `<< 6` instead of `* 2^6 == * 64`

TL;DR:
- Shifting left by N is like multiplying by 2^N (Each bits to the left is an increased power of 2)
- Shifting right by N is like dividing by 2^N (Each bits to the right is a decreased power of 2)

*Saves around 2 gas + 20 for unchecked per instance*

*Instances (38)*:
```solidity
File: ./contracts/assetManager/facets/LiquidationFacet.sol

217:             return _amount / 2;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/LiquidationFacet.sol)

```solidity
File: ./contracts/assetManager/facets/RedemptionTimeExtensionFacet.sol

49:         require(_value <= currentValue * 4 + settings.averageBlockTimeMS / 1000, IncreaseTooBig());

50:         require(_value >= currentValue / 4, DecreaseTooBig());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/RedemptionTimeExtensionFacet.sol)

```solidity
File: ./contracts/assetManager/facets/SettingsManagementFacet.sol

216:         require(_rewardNATWei <= (settings.paymentChallengeRewardUSD5 * 4) + 100 ether, IncreaseTooBig());

217:         require(_rewardNATWei >= (settings.paymentChallengeRewardUSD5) / 4, DecreaseTooBig());

218:         require(_rewardBIPS <= (settings.paymentChallengeRewardBIPS * 4) + 100, IncreaseTooBig());

219:         require(_rewardBIPS >= (settings.paymentChallengeRewardBIPS) / 4, DecreaseTooBig());

267:         require(_value <= settings.maxTrustedPriceAgeSeconds * 2, FeeIncreaseTooBig());

268:         require(_value >= settings.maxTrustedPriceAgeSeconds / 2, FeeDecreaseTooBig());

283:         require(_value <= settings.collateralReservationFeeBIPS * 4, FeeIncreaseTooBig());

284:         require(_value >= settings.collateralReservationFeeBIPS / 4, FeeDecreaseTooBig());

299:         require(_value <= settings.redemptionFeeBIPS * 4, FeeIncreaseTooBig());

300:         require(_value >= settings.redemptionFeeBIPS / 4, FeeDecreaseTooBig());

345:         require(_value <= settings.confirmationByOthersRewardUSD5 * 4, FeeIncreaseTooBig());

346:         require(_value >= settings.confirmationByOthersRewardUSD5 / 4, FeeDecreaseTooBig());

360:         require(_value <= settings.maxRedeemedTickets * 2, IncreaseTooBig());

361:         require(_value >= settings.maxRedeemedTickets / 4, DecreaseTooBig());

403:         require(_value <= settings.averageBlockTimeMS * 2, IncreaseTooBig());

404:         require(_value >= settings.averageBlockTimeMS / 2, DecreaseTooBig());

417:         require(_value <= settings.mintingPoolHoldingsRequiredBIPS * 4 + SafePct.MAX_BIPS, ValueTooBig());

468:         require(_value <= settings.agentExitAvailableTimelockSeconds * 4 + 1 weeks, ValueTooBig());

481:         require(_value <= settings.agentFeeChangeTimelockSeconds * 4 + 1 days, ValueTooBig());

494:         require(_value <= settings.agentMintingCRChangeTimelockSeconds * 4 + 1 days, ValueTooBig());

507:         require(_value <= settings.poolExitCRChangeTimelockSeconds * 4 + 1 days, ValueTooBig());

547:         require(_stepSeconds <= settings.liquidationStepSeconds * 2, IncreaseTooBig());

548:         require(_stepSeconds >= settings.liquidationStepSeconds / 2, DecreaseTooBig());

585:         require(_value <= settings.maxEmergencyPauseDurationSeconds * 4 + 60, IncreaseTooBig());

586:         require(_value >= settings.maxEmergencyPauseDurationSeconds / 4, DecreaseTooBig());

601:         require(_value <= settings.emergencyPauseDurationResetAfterSeconds * 4 + 3600, IncreaseTooBig());

602:         require(_value >= settings.emergencyPauseDurationResetAfterSeconds / 4, DecreaseTooBig());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/SettingsManagementFacet.sol)

```solidity
File: ./contracts/assetManager/library/AgentUpdates.sol

128:         require(_poolExitCollateralRatioBIPS <= currentExitCR * 3 / 2 ||

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/AgentUpdates.sol)

```solidity
File: ./contracts/fassetToken/library/CheckPointHistory.sol

61:             uint256 mid = (max + min + 1) / 2;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/library/CheckPointHistory.sol)

```solidity
File: ./contracts/ftso/implementation/FtsoV2PriceStore.sol

115:         submitTrustedPricesWindowSeconds = _votingEpochDurationSeconds / 2; // 45 s

163:                     priceStore.numberOfSubmits = uint8(trustedPrices.length / 4);

409:                 price[j] = _prices[i * 4 + j];

429:         uint256 middleIndex = length / 2;

433:                 spread = (prices[middleIndex + 1] - prices[middleIndex - 1]) / 2;

437:             _medianPrice = (prices[middleIndex - 1] + prices[middleIndex]) / 2;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/ftso/implementation/FtsoV2PriceStore.sol)

### <a name="GAS-12"></a>[GAS-12] Splitting require() statements that use && saves gas

*Instances (3)*:
```solidity
File: ./contracts/assetManager/library/data/Agent.sol

202:         require(status != Agent.Status.EMPTY && status != Agent.Status.DESTROYED, InvalidAgentVaultAddress());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/Agent.sol)

```solidity
File: ./contracts/ftso/implementation/FtsoV2PriceStore.sol

183:         require(block.timestamp >= startTimestamp && block.timestamp < endTimestamp, SubmissionWindowClosed());

214:         require(_feedIds.length == _symbols.length && _feedIds.length == _trustedDecimals.length, LengthMismatch());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/ftso/implementation/FtsoV2PriceStore.sol)

### <a name="GAS-13"></a>[GAS-13] Superfluous event fields
`block.timestamp` and `block.number` are added to event information by default so adding them manually wastes gas

*Instances (3)*:
```solidity
File: ./contracts/assetManager/facets/LiquidationFacet.sol

162:             emit IAssetManagerEvents.LiquidationStarted(_agent.vaultAddress(), block.timestamp);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/LiquidationFacet.sol)

```solidity
File: ./contracts/assetManager/library/Liquidation.sol

45:         emit IAssetManagerEvents.FullLiquidationStarted(_agent.vaultAddress(), block.timestamp);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Liquidation.sol)

```solidity
File: ./contracts/fassetToken/implementation/CheckPointable.sol

40:     event CreatedTotalSupplyCache(uint256 _blockNumber);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/implementation/CheckPointable.sol)

### <a name="GAS-14"></a>[GAS-14] Increments/decrements can be unchecked in for-loops
In Solidity 0.8+, there's a default overflow check on unsigned integers. It's possible to uncheck this in for-loops and save some gas at each iteration, but at the cost of some code readability, as this uncheck cannot be made inline.

[ethereum/solidity#10695](https://github.com/ethereum/solidity/issues/10695)

The change would be:

```diff
- for (uint256 i; i < numIterations; i++) {
+ for (uint256 i; i < numIterations;) {
 // ...
+   unchecked { ++i; }
}
```

These save around **25 gas saved** per instance.

The same can be applied with decrements (which should use `break` when `i == 0`).

The risk of overflow is non-existent for `uint256`.

*Instances (58)*:
```solidity
File: ./contracts/assetManager/facets/AgentVaultManagementFacet.sol

225:         for (uint256 i = 0; i < _agents.length; i++) {

294:         for (uint256 i = 0; i < len; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentVaultManagementFacet.sol)

```solidity
File: ./contracts/assetManager/facets/AvailableAgentsFacet.sol

127:         for (uint256 i = _start; i < _end; i++) {

153:         for (uint256 i = _start; i < _end; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AvailableAgentsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/ChallengesFacet.sol

155:         for (uint256 i = 0; i < _payments.length; i++) {

159:             for (uint256 j = 0; j < i; j++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/ChallengesFacet.sol)

```solidity
File: ./contracts/assetManager/facets/RedemptionRequestsFacet.sol

74:         for (uint256 i = 0; i < maxRedeemedTickets && redeemedLots < _lots; i++) {

84:         for (uint256 i = 0; i < redemptionList.length; i++) {

178:         for (uint256 i = 0; ticketId != 0 && i < maxRedeemedTickets; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/RedemptionRequestsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/SettingsManagementFacet.sol

568:         for (uint256 i = 0; i < _liquidationFactors.length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/SettingsManagementFacet.sol)

```solidity
File: ./contracts/assetManager/library/Agents.sol

41:         for (uint256 i = _start; i < _end; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Agents.sol)

```solidity
File: ./contracts/assetManager/library/CollateralTypes.sol

38:         for (uint256 i = 1; i < _data.length; i++) {

80:         for (uint256 i = 0; i < length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/CollateralTypes.sol)

```solidity
File: ./contracts/assetManager/library/Redemptions.sol

34:         for (uint256 i = 0; i < maxRedeemedTickets && _closedAMG < _amountAMG; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Redemptions.sol)

```solidity
File: ./contracts/assetManager/library/SettingsValidators.sol

38:         for (uint256 i = 0; i < liquidationFactors.length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/SettingsValidators.sol)

```solidity
File: ./contracts/assetManagerController/implementation/AssetManagerController.sol

125:         for (uint256 i = 0; i < length; i++) {

715:         for (uint256 i = 0; i < _assetManagers.length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManagerController/implementation/AssetManagerController.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPoolToken.sol

177:         for (uint256 i = timelocks.start; i < end; i++) {

233:         for (uint256 count = 0; count < _maxTimelockedEntries; count++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPoolToken.sol)

```solidity
File: ./contracts/coreVaultManager/implementation/CoreVaultManager.sol

193:             for (uint256 i = 0; i < cancelableTransferRequests.length; i++) {

306:                 for (uint256 i = index; i < length - 1; i++) { // length > 0

338:                 for (uint256 i = index; i < length - 1; i++) { // length > 0

410:         for (uint256 i = 0; i < _allowedDestinationAddresses.length; i++) {

432:         for (uint256 i = 0; i < _allowedDestinationAddresses.length; i++) {

460:         for (uint256 i = 0; i < _triggeringAccounts.length; i++) {

478:         for (uint256 i = 0; i < _triggeringAccounts.length; i++) {

538:         for (uint256 i = 0; i < _preimageHashes.length; i++) {

578:         for (uint256 i = 0; i < _preimageHashes.length; i++) {

603:         for (uint256 i = 0; i < _addresses.length; i++) {

619:         for (uint256 i = 0; i < _addresses.length; i++) {

699:         for (uint256 i = 0; i < length; i++) {

732:         for (uint256 i = 0; i < length; i++) {

757:         for (uint256 i = 0; i < cancelableTransferRequests.length; i++) {

767:         for (uint256 i = 0; i < nonCancelableTransferRequests.length; i++) {

868:         for (uint256 i = escrows.length; i > nextUnprocessedEscrowIndex; i--) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/coreVaultManager/implementation/CoreVaultManager.sol)

```solidity
File: ./contracts/diamond/facets/DiamondLoupeFacet.sol

41:         for (uint256 selectorIndex; selectorIndex < selectorCount; selectorIndex++) {

46:             for (uint256 facetIndex; facetIndex < numFacets; facetIndex++) {

66:         for (uint256 facetIndex; facetIndex < numFacets; facetIndex++) {

92:         for (uint256 selectorIndex; selectorIndex < selectorCount; selectorIndex++) {

118:         for (uint256 selectorIndex; selectorIndex < selectorCount; selectorIndex++) {

123:             for (uint256 facetIndex; facetIndex < numFacets; facetIndex++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/diamond/facets/DiamondLoupeFacet.sol)

```solidity
File: ./contracts/diamond/library/LibDiamond.sol

61:         for (uint256 facetIndex; facetIndex < _diamondCut.length; facetIndex++) {

89:         for (uint256 selectorIndex; selectorIndex < _functionSelectors.length; selectorIndex++) {

108:         for (uint256 selectorIndex; selectorIndex < _functionSelectors.length; selectorIndex++) {

132:         for (uint256 selectorIndex; selectorIndex < _functionSelectors.length; selectorIndex++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/diamond/library/LibDiamond.sol)

```solidity
File: ./contracts/flareSmartContracts/implementation/AddressUpdatable.sol

72:         for (uint256 i = 0; i < _nameHashes.length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/flareSmartContracts/implementation/AddressUpdatable.sol)

```solidity
File: ./contracts/ftso/implementation/FtsoV2PriceStore.sol

126:         for (uint256 i = 0; i < _proofs.length; i++) {

188:         for (uint256 i = 0; i < _feeds.length; i++) {

218:         for (uint256 i = 0; i < _feedIds.length; i++) {

228:                 for (uint32 j = lastPublishedVotingRoundId + 1; j <= _getPreviousVotingEpochId(); j++) {

251:         for (uint256 i = 0; i < trustedProviders.length; i++) {

256:         for (uint256 i = 0; i < _trustedProviders.length; i++) {

322:         for (uint256 i = 0; i < _feedIds.length; i++) {

332:         for (uint256 i = 0; i < feedIds.length; i++) {

406:         for (uint256 i = 0; i < length; i++) {

408:             for (uint256 j = 0; j < 4; j++) {

414:         for (uint256 i = 1; i < length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/ftso/implementation/FtsoV2PriceStore.sol)

```solidity
File: ./contracts/utils/library/MerkleTree.sol

74:         for (uint256 initialLevel = 0; initialLevel < 2; initialLevel++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/utils/library/MerkleTree.sol)

### <a name="GAS-15"></a>[GAS-15] Use != 0 instead of > 0 for unsigned integer comparison

*Instances (121)*:
```solidity
File: ./contracts/assetManager/facets/AgentVaultManagementFacet.sol

254:             if (initCall.length > 0) {

297:             require((ch >= "A" && ch <= "Z") || (ch >= "0" && ch <= "9") || (i > 0 && i < len - 1 && ch == "-"),

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentVaultManagementFacet.sol)

```solidity
File: ./contracts/assetManager/facets/CollateralReservationsFacet.sol

75:         require(_lots > 0, CannotMintZeroLots());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/CollateralReservationsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/CoreVaultClientFacet.sol

86:         require(_amountUBA > 0, ZeroTransferNotAllowed());

94:         require(transferredAMG > 0, NothingMinted());

137:         require(_lots > 0, CannotReturnZeroLots());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/CoreVaultClientFacet.sol)

```solidity
File: ./contracts/assetManager/facets/LiquidationFacet.sol

87:         if (payoutC1Wei > 0) {

90:         if (payoutPoolWei > 0) {

96:         if (_liquidatedAmountUBA > 0) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/LiquidationFacet.sol)

```solidity
File: ./contracts/assetManager/facets/MintingFacet.sol

148:         if (_lots > 0) {

179:         require(_lots > 0, CannotMintZeroLots());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/MintingFacet.sol)

```solidity
File: ./contracts/assetManager/facets/RedemptionConfirmationsFacet.sol

155:         if (poolFeeUBA > 0) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/RedemptionConfirmationsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/RedemptionRequestsFacet.sol

308:         if (_redeemedLots > 0) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/RedemptionRequestsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/RedemptionTimeExtensionFacet.sol

51:         require(_value > 0, ValueMustBeNonzero());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/RedemptionTimeExtensionFacet.sol)

```solidity
File: ./contracts/assetManager/facets/SettingsManagementFacet.sol

184:         if (callData.length > 0) {

199:         require(_underlyingSeconds > 0, CannotBeZero());

200:         require(_underlyingBlocks > 0, CannotBeZero());

234:         require(_value > 0, CannotBeZero());

249:         require(_value > 0, CannotBeZero());

266:         require(_value > 0, CannotBeZero());

281:         require(_value > 0, CannotBeZero());

297:         require(_value > 0, CannotBeZero());

344:         require(_value > 0, CannotBeZero());

359:         require(_value > 0, CannotBeZero());

375:         require(_value > 0, CannotBeZero());

402:         require(_value > 0, CannotBeZero());

546:         require(_stepSeconds > 0, CannotBeZero());

584:         require(_value > 0, CannotBeZero());

600:         require(_value > 0, CannotBeZero());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/SettingsManagementFacet.sol)

```solidity
File: ./contracts/assetManager/facets/SystemInfoFacet.sol

96:             poolFeeShareBIPS: crt.poolFeeShareBIPS > 0 ? crt.poolFeeShareBIPS - 1 : agent.poolFeeShareBIPS,

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/SystemInfoFacet.sol)

```solidity
File: ./contracts/assetManager/library/AgentBacking.sol

69:         if (ticketValueAMG > 0) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/AgentBacking.sol)

```solidity
File: ./contracts/assetManager/library/AgentCollateral.sol

242:         return _data.fullCollateral.mulDiv(_valueAMG, totalAMG); // totalAMG > 0 (guarded by assert)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/AgentCollateral.sol)

```solidity
File: ./contracts/assetManager/library/CollateralTypes.sol

94:         require(index > 0, UnknownToken());

107:         require(index > 0, UnknownToken());

120:         return index > 0;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/CollateralTypes.sol)

```solidity
File: ./contracts/assetManager/library/Minting.sol

41:         if (executorFeeNatWei > 0) {

73:         require(_crtId > 0, InvalidCrtId());

106:         uint16 poolFeeShareBIPS = storedPoolFeeShareBIPS > 0 ? storedPoolFeeShareBIPS - 1 : _agent.poolFeeShareBIPS;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Minting.sol)

```solidity
File: ./contracts/assetManager/library/RedemptionDefaults.sol

44:             if (paidPoolWei > 0) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/RedemptionDefaults.sol)

```solidity
File: ./contracts/assetManager/library/Redemptions.sol

50:         if (closeDustAMG > 0) {

102:         if (executorFeeNatWei > 0) {

119:         if (executorFeeNatWei > 0) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Redemptions.sol)

```solidity
File: ./contracts/assetManager/library/SettingsInitializer.sol

64:         require(_settings.assetUnitUBA > 0, CannotBeZero());

65:         require(_settings.assetMintingGranularityUBA > 0, CannotBeZero());

66:         require(_settings.underlyingBlocksForPayment > 0, CannotBeZero());

67:         require(_settings.underlyingSecondsForPayment > 0, CannotBeZero());

68:         require(_settings.redemptionFeeBIPS > 0, CannotBeZero());

69:         require(_settings.collateralReservationFeeBIPS > 0, CannotBeZero());

70:         require(_settings.confirmationByOthersRewardUSD5 > 0, CannotBeZero());

71:         require(_settings.maxRedeemedTickets > 0, CannotBeZero());

72:         require(_settings.maxTrustedPriceAgeSeconds > 0, CannotBeZero());

73:         require(_settings.minUpdateRepeatTimeSeconds > 0, CannotBeZero());

74:         require(_settings.withdrawalWaitMinSeconds > 0, CannotBeZero());

75:         require(_settings.averageBlockTimeMS > 0, CannotBeZero());

78:         require(_settings.lotSizeAMG > 0, CannotBeZero());

89:         require(_settings.liquidationStepSeconds > 0, CannotBeZero());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/SettingsInitializer.sol)

```solidity
File: ./contracts/assetManager/library/SettingsValidators.sol

27:         require(_underlyingBlocks * _averageBlockTimeMS / 1000 <= MAXIMUM_PROOF_WINDOW, ValueTooHigh());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/SettingsValidators.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPool.sol

146:         require(tokenShare > 0, DepositResultsInZeroTokens());

148:         uint256 feeDebt = totalPoolTokens > 0 ? _totalVirtualFees().mulDiv(tokenShare, totalPoolTokens) : 0;

193:         require(_tokenShare > 0, TokenShareIsZero());

198:         require(natShare > 0, SentAmountTooLow());

277:         require(_tokenShare > 0, TokenShareIsZero());

282:         require(natShare > 0, SentAmountTooLow());

296:         if (requiredFAssets > 0) {

362:         require(_fAssets > 0, WithdrawZeroFAsset());

402:         uint256 maxSlashedTokens = totalCollateral > 0 ?

405:         if (slashedTokens > 0) {

648:         if (_amount > 0) {

660:         if (_amount > 0) {

672:         if (_amount > 0) {

684:         if (_amount > 0) {

697:         if (msg.value > 0) {

776:         if (untrackedWNat > 0) {

779:         if (untrackedFAsset > 0) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPool.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPoolToken.sol

103:         if (timelockDuration > 0 && _amount > 0) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPoolToken.sol)

```solidity
File: ./contracts/coreVaultManager/implementation/CoreVaultManager.sol

134:         require(bytes(_custodianAddress).length > 0, InvalidAddress());

135:         require(bytes(_coreVaultAddress).length > 0, InvalidAddress());

161:         require(_proof.data.responseBody.receivedAmount > 0, InvalidAmount());

187:         require(_amount > 0, AmountZero());

260:         while (index < cancelableTransferRequests.length - 1) { // length > 0

286:         require(feeTmp > 0, FeeZero());

306:                 for (uint256 i = index; i < length - 1; i++) { // length > 0

338:                 for (uint256 i = index; i < length - 1; i++) { // length > 0

351:         if (escrowAmountTmp == 0 || length > 0 || cancelableTransferRequests.length > 0) {

411:             require(bytes(_allowedDestinationAddresses[i]).length > 0, InvalidAddress());

496:         require(bytes(_custodianAddress).length > 0, InvalidAddress());

519:         require(_fee > 0, FeeZero());

557:         while (_maxCount > 0 && index > nextUnusedPreimageHashIndex) {

683:         return allowedDestinationAddressIndex[_address] > 0;

825:         while (_maxCount > 0 && index < escrows.length &&

844:         _allProcessed = _maxCount > 0 || index == escrows.length ||

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/coreVaultManager/implementation/CoreVaultManager.sol)

```solidity
File: ./contracts/diamond/library/LibDiamond.sol

166:             if (error.length > 0) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/diamond/library/LibDiamond.sol)

```solidity
File: ./contracts/ftso/implementation/FtsoV2PriceStore.sol

156:             if (trustedPrices.length > 0 && trustedPrices.length >= 4 * trustedProvidersThreshold) {

403:         assert(length > 0 && length % 4 == 0);

420:             while (j > 0 && prices[j - 1] > currentPrice) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/ftso/implementation/FtsoV2PriceStore.sol)

```solidity
File: ./contracts/userInterfaces/IAgentAlwaysAllowedMinters.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAgentAlwaysAllowedMinters.sol)

```solidity
File: ./contracts/userInterfaces/IAgentOwnerRegistry.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAgentOwnerRegistry.sol)

```solidity
File: ./contracts/userInterfaces/IAgentPing.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAgentPing.sol)

```solidity
File: ./contracts/userInterfaces/IAgentVault.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAgentVault.sol)

```solidity
File: ./contracts/userInterfaces/IAssetManager.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAssetManager.sol)

```solidity
File: ./contracts/userInterfaces/IAssetManagerController.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAssetManagerController.sol)

```solidity
File: ./contracts/userInterfaces/IAssetManagerEvents.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAssetManagerEvents.sol)

```solidity
File: ./contracts/userInterfaces/ICollateralPool.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/ICollateralPool.sol)

```solidity
File: ./contracts/userInterfaces/ICollateralPoolToken.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/ICollateralPoolToken.sol)

```solidity
File: ./contracts/userInterfaces/ICoreVaultClient.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/ICoreVaultClient.sol)

```solidity
File: ./contracts/userInterfaces/ICoreVaultClientSettings.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/ICoreVaultClientSettings.sol)

```solidity
File: ./contracts/userInterfaces/ICoreVaultManager.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/ICoreVaultManager.sol)

```solidity
File: ./contracts/userInterfaces/IFAsset.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IFAsset.sol)

```solidity
File: ./contracts/userInterfaces/IRedemptionTimeExtension.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IRedemptionTimeExtension.sol)

```solidity
File: ./contracts/userInterfaces/data/AgentInfo.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/AgentInfo.sol)

```solidity
File: ./contracts/userInterfaces/data/AgentSettings.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/AgentSettings.sol)

```solidity
File: ./contracts/userInterfaces/data/AssetManagerSettings.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/AssetManagerSettings.sol)

```solidity
File: ./contracts/userInterfaces/data/AvailableAgentInfo.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/AvailableAgentInfo.sol)

```solidity
File: ./contracts/userInterfaces/data/CollateralReservationInfo.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/CollateralReservationInfo.sol)

```solidity
File: ./contracts/userInterfaces/data/CollateralType.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/CollateralType.sol)

```solidity
File: ./contracts/userInterfaces/data/RedemptionRequestInfo.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/RedemptionRequestInfo.sol)

```solidity
File: ./contracts/userInterfaces/data/RedemptionTicketInfo.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/RedemptionTicketInfo.sol)

```solidity
File: ./contracts/utils/library/MerkleTree.sol

33:         require(leaves.length > 0, NoLeaves());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/utils/library/MerkleTree.sol)

```solidity
File: ./contracts/utils/library/SafePct.sol

25:         require(z > 0, DivisionByZero());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/utils/library/SafePct.sol)

```solidity
File: ./contracts/utils/library/Transfers.sol

34:         if (_amount > 0) {

53:         if (_amount > 0) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/utils/library/Transfers.sol)


## Non Critical Issues


| |Issue|Instances|
|-|:-|:-:|
| [NC-1](#NC-1) | Replace `abi.encodeWithSignature` and `abi.encodeWithSelector` with `abi.encodeCall` which keeps the code typo/type safe | 2 |
| [NC-2](#NC-2) | abicoder v2 is enabled by default | 4 |
| [NC-3](#NC-3) | `require()` should be used instead of `assert()` | 47 |
| [NC-4](#NC-4) | `constant`s should be defined rather than using magic numbers | 80 |
| [NC-5](#NC-5) | Control structures do not follow the Solidity Style Guide | 162 |
| [NC-6](#NC-6) | Critical Changes Should Use Two-step Procedure | 1 |
| [NC-7](#NC-7) | Functions should not be longer than 50 lines | 382 |
| [NC-8](#NC-8) | Change int to int256 | 5 |
| [NC-9](#NC-9) | `mapping` definitions do not follow the Solidity Style Guide | 4 |
| [NC-10](#NC-10) | Use a `modifier` instead of a `require/if` statement for a special `msg.sender` actor | 38 |
| [NC-11](#NC-11) | Consider using named mappings | 26 |
| [NC-12](#NC-12) | `address`s shouldn't be hard-coded | 1 |
| [NC-13](#NC-13) | Numeric values having to do with time should use time units for readability | 1 |
| [NC-14](#NC-14) | Take advantage of Custom Error's return value property | 3 |
| [NC-15](#NC-15) | Deprecated library used for Solidity `>= 0.8` : SafeMath | 9 |
| [NC-16](#NC-16) | Avoid the use of sensitive terms | 32 |
| [NC-17](#NC-17) | Some require descriptions are not clear | 1 |
| [NC-18](#NC-18) | Use Underscores for Number Literals (add an underscore every 3 digits) | 10 |
| [NC-19](#NC-19) | Constants should be defined rather than using magic numbers | 2 |
| [NC-20](#NC-20) | Variables need not be initialized to zero | 50 |
### <a name="NC-1"></a>[NC-1] Replace `abi.encodeWithSignature` and `abi.encodeWithSelector` with `abi.encodeCall` which keeps the code typo/type safe
When using `abi.encodeWithSignature`, it is possible to include a typo for the correct function signature.
When using `abi.encodeWithSignature` or `abi.encodeWithSelector`, it is also possible to provide parameters that are not of the correct type for the function.

To avoid these pitfalls, it would be best to use [`abi.encodeCall`](https://solidity-by-example.org/abi-encode/) instead.

*Instances (2)*:
```solidity
File: ./contracts/assetManagerController/implementation/AssetManagerController.sol

707:         _callOnManagers(_assetManagers, abi.encodeWithSelector(_selector, (_value)));

711:         _callOnManagers(_assetManagers, abi.encodeWithSelector(_selector, (_value)));

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManagerController/implementation/AssetManagerController.sol)

### <a name="NC-2"></a>[NC-2] abicoder v2 is enabled by default
abicoder v2 is considered non-experimental as of Solidity 0.6.0 and it is enabled by default starting with Solidity 0.8.0. Therefore, there is no need to write.

*Instances (4)*:
```solidity
File: ./contracts/userInterfaces/IAgentOwnerRegistry.sol

3: pragma abicoder v2;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAgentOwnerRegistry.sol)

```solidity
File: ./contracts/userInterfaces/IAgentVault.sol

3: pragma abicoder v2;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAgentVault.sol)

```solidity
File: ./contracts/userInterfaces/ICollateralPool.sol

3: pragma abicoder v2;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/ICollateralPool.sol)

```solidity
File: ./contracts/userInterfaces/ICollateralPoolToken.sol

3: pragma abicoder v2;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/ICollateralPoolToken.sol)

### <a name="NC-3"></a>[NC-3] `require()` should be used instead of `assert()`
Prior to solidity version 0.8.0, hitting an assert consumes the **remainder of the transaction's available gas** rather than returning it, as `require()`/`revert()` do. `assert()` should be avoided even past solidity version 0.8.0 as its [documentation](https://docs.soliditylang.org/en/v0.8.14/control-structures.html#panic-via-assert-and-error-via-require) states that "The assert function creates an error of type Panic(uint256). ... Properly functioning code should never create a Panic, not even on invalid external input. If this happens, then there is a bug in your contract which you should fix. Additionally, a require statement (or a custom error) are more friendly in terms of understanding what happened."

*Instances (47)*:
```solidity
File: ./contracts/assetManager/facets/AgentSettingsFacet.sol

108:             assert(false);

134:             assert(false);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentSettingsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/AgentVaultManagementFacet.sol

83:         assert(agent.status == Agent.Status.EMPTY);     // state should be empty on creation

170:         assert(agent.totalBackedAMG() == 0);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentVaultManagementFacet.sol)

```solidity
File: ./contracts/assetManager/facets/CoreVaultClientFacet.sol

147:         assert(agent.returnFromCoreVaultReservedAMG == 0);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/CoreVaultClientFacet.sol)

```solidity
File: ./contracts/assetManager/facets/RedemptionConfirmationsFacet.sol

94:             assert(request.status == Redemption.Status.ACTIVE); // checked in _validatePayment that is not DEFAULTED

107:                 assert(_payment.data.responseBody.status == TransactionAttestation.PAYMENT_BLOCKED);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/RedemptionConfirmationsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/RedemptionRequestsFacet.sol

203:         assert(!request.transferToCoreVault);   // we have a problem if core vault has invalid address

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/RedemptionRequestsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/SystemInfoFacet.sol

146:             assert(_status == CollateralReservation.Status.EXPIRED);

167:             assert(_status == Redemption.Status.REJECTED);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/SystemInfoFacet.sol)

```solidity
File: ./contracts/assetManager/library/AgentCollateral.sol

240:         assert(_valueAMG <= redeemingAMG);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/AgentCollateral.sol)

```solidity
File: ./contracts/assetManager/library/AgentUpdates.sol

36:         assert(collateral.collateralClass == CollateralType.Class.VAULT);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/AgentUpdates.sol)

```solidity
File: ./contracts/assetManager/library/Agents.sol

204:             assert(_kind == Collateral.Kind.POOL);

225:         assert(_agent.poolRedeemingAMG <= _agent.redeemingAMG);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Agents.sol)

```solidity
File: ./contracts/assetManager/library/CollateralTypes.sol

173:         assert(token.collateralClass == CollateralType.Class.POOL);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/CollateralTypes.sol)

```solidity
File: ./contracts/assetManager/library/Conversion.sol

190:         assert(expPlus >= expMinus);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Conversion.sol)

```solidity
File: ./contracts/assetManager/library/CoreVaultClient.sol

88:         assert(_agent.activeReturnFromCoreVaultId != 0 && _agent.returnFromCoreVaultReservedAMG != 0);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/CoreVaultClient.sol)

```solidity
File: ./contracts/assetManager/library/Minting.sol

62:         assert(_status != CollateralReservation.Status.ACTIVE);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Minting.sol)

```solidity
File: ./contracts/assetManager/library/RedemptionDefaults.sol

34:         assert(_request.status == Redemption.Status.ACTIVE);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/RedemptionDefaults.sol)

```solidity
File: ./contracts/assetManager/library/Redemptions.sol

142:         assert(_status >= Redemption.Status.SUCCESSFUL);    // must be a final status

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Redemptions.sol)

```solidity
File: ./contracts/assetManager/library/data/PaymentReference.sol

25:         assert(_id <= MAX_ID);

30:         assert(_id <= MAX_ID);

35:         assert(_id <= MAX_ID);

40:         assert(_id <= MAX_ID);

45:         assert(_id <= MAX_ID);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/PaymentReference.sol)

```solidity
File: ./contracts/assetManager/library/data/RedemptionQueue.sol

49:             assert(_state.lastTicketId == 0);    // empty queue - first and last must be 0

52:             assert(_state.lastTicketId != 0);    // non-empty queue - first and last must be non-zero

58:             assert(agent.lastTicketId == 0);    // empty queue - first and last must be 0

61:             assert(agent.lastTicketId != 0);    // non-empty queue - first and last must be non-zero

76:         assert(ticket.agentVault != address(0));

80:             assert(_ticketId == _state.firstTicketId);     // ticket is first in queue

83:             assert(_ticketId != _state.firstTicketId);     // ticket is not first in queue

87:             assert(_ticketId == _state.lastTicketId);     // ticket is last in queue

90:             assert(_ticketId != _state.lastTicketId);     // ticket is not last in queue

95:             assert(_ticketId == agent.firstTicketId);     // ticket is first in agent queue

98:             assert(_ticketId != agent.firstTicketId);     // ticket is not first in agent queue

102:             assert(_ticketId == agent.lastTicketId);     // ticket is last in agent queue

105:             assert(_ticketId != agent.lastTicketId);     // ticket is not last in agent queue

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/RedemptionQueue.sol)

```solidity
File: ./contracts/assetManagerController/implementation/AssetManagerController.sol

173:         assert(false);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManagerController/implementation/AssetManagerController.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPool.sol

437:         assert(_tokens <= totalPoolTokens);

537:         assert(virtualFassets <= _totalVirtualFees());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPool.sol)

```solidity
File: ./contracts/fassetToken/library/CheckPointsByAddress.sol

40:         assert(!(_from == address(0) && _to == address(0)));

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/library/CheckPointsByAddress.sol)

```solidity
File: ./contracts/ftso/implementation/FtsoV2PriceStore.sol

403:         assert(length > 0 && length % 4 == 0);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/ftso/implementation/FtsoV2PriceStore.sol)

```solidity
File: ./contracts/governance/implementation/GovernedBase.sol

150:             assert(msg.sender == address(this));

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/governance/implementation/GovernedBase.sol)

```solidity
File: ./contracts/governance/implementation/GovernedUUPSProxyImplementation.sol

49:         assert(false);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/governance/implementation/GovernedUUPSProxyImplementation.sol)

```solidity
File: ./contracts/utils/library/MerkleTree.sol

126:                 assert(false);

129:         assert(stackTop == 1);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/utils/library/MerkleTree.sol)

### <a name="NC-4"></a>[NC-4] `constant`s should be defined rather than using magic numbers
Even [assembly](https://github.com/code-423n4/2022-05-opensea-seaport/blob/9d7ce4d08bf3c3010304a0476a785c70c0e90ae7/contracts/lib/TokenTransferrer.sol#L35-L39) can benefit from using readable constants instead of hex/numeric literals

*Instances (80)*:
```solidity
File: ./contracts/assetManager/facets/CollateralReservationsFacet.sol

193:         uint64 blockshift = (uint256(timeshift) * 1000 / settings.averageBlockTimeMS).toUint64();

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/CollateralReservationsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/LiquidationFacet.sol

217:             return _amount / 2;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/LiquidationFacet.sol)

```solidity
File: ./contracts/assetManager/facets/RedemptionTimeExtensionFacet.sol

49:         require(_value <= currentValue * 4 + settings.averageBlockTimeMS / 1000, IncreaseTooBig());

50:         require(_value >= currentValue / 4, DecreaseTooBig());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/RedemptionTimeExtensionFacet.sol)

```solidity
File: ./contracts/assetManager/facets/SettingsManagementFacet.sol

216:         require(_rewardNATWei <= (settings.paymentChallengeRewardUSD5 * 4) + 100 ether, IncreaseTooBig());

217:         require(_rewardNATWei >= (settings.paymentChallengeRewardUSD5) / 4, DecreaseTooBig());

218:         require(_rewardBIPS <= (settings.paymentChallengeRewardBIPS * 4) + 100, IncreaseTooBig());

219:         require(_rewardBIPS >= (settings.paymentChallengeRewardBIPS) / 4, DecreaseTooBig());

250:         require(_value <= settings.lotSizeAMG * 10, LotSizeIncreaseTooBig());

251:         require(_value >= settings.lotSizeAMG / 10, LotSizeDecreaseTooBig());

267:         require(_value <= settings.maxTrustedPriceAgeSeconds * 2, FeeIncreaseTooBig());

268:         require(_value >= settings.maxTrustedPriceAgeSeconds / 2, FeeDecreaseTooBig());

283:         require(_value <= settings.collateralReservationFeeBIPS * 4, FeeIncreaseTooBig());

284:         require(_value >= settings.collateralReservationFeeBIPS / 4, FeeDecreaseTooBig());

299:         require(_value <= settings.redemptionFeeBIPS * 4, FeeIncreaseTooBig());

300:         require(_value >= settings.redemptionFeeBIPS / 4, FeeDecreaseTooBig());

315:         require(_value <= uint256(settings.redemptionDefaultFactorVaultCollateralBIPS).mulBips(12000) + 1000,

331:         require(_value >= 2 hours, MustBeAtLeastTwoHours());

345:         require(_value <= settings.confirmationByOthersRewardUSD5 * 4, FeeIncreaseTooBig());

346:         require(_value >= settings.confirmationByOthersRewardUSD5 / 4, FeeDecreaseTooBig());

360:         require(_value <= settings.maxRedeemedTickets * 2, IncreaseTooBig());

361:         require(_value >= settings.maxRedeemedTickets / 4, DecreaseTooBig());

376:         require(_value <= settings.withdrawalWaitMinSeconds + 10 minutes, IncreaseTooBig());

403:         require(_value <= settings.averageBlockTimeMS * 2, IncreaseTooBig());

404:         require(_value >= settings.averageBlockTimeMS / 2, DecreaseTooBig());

417:         require(_value <= settings.mintingPoolHoldingsRequiredBIPS * 4 + SafePct.MAX_BIPS, ValueTooBig());

468:         require(_value <= settings.agentExitAvailableTimelockSeconds * 4 + 1 weeks, ValueTooBig());

481:         require(_value <= settings.agentFeeChangeTimelockSeconds * 4 + 1 days, ValueTooBig());

494:         require(_value <= settings.agentMintingCRChangeTimelockSeconds * 4 + 1 days, ValueTooBig());

507:         require(_value <= settings.poolExitCRChangeTimelockSeconds * 4 + 1 days, ValueTooBig());

547:         require(_stepSeconds <= settings.liquidationStepSeconds * 2, IncreaseTooBig());

548:         require(_stepSeconds >= settings.liquidationStepSeconds / 2, DecreaseTooBig());

585:         require(_value <= settings.maxEmergencyPauseDurationSeconds * 4 + 60, IncreaseTooBig());

586:         require(_value >= settings.maxEmergencyPauseDurationSeconds / 4, DecreaseTooBig());

601:         require(_value <= settings.emergencyPauseDurationResetAfterSeconds * 4 + 3600, IncreaseTooBig());

602:         require(_value >= settings.emergencyPauseDurationResetAfterSeconds / 4, DecreaseTooBig());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/SettingsManagementFacet.sol)

```solidity
File: ./contracts/assetManager/library/AgentUpdates.sol

112:         require(_buyFAssetByAgentFactorBIPS >= 9000, ValueTooLow());

128:         require(_poolExitCollateralRatioBIPS <= currentExitCR * 3 / 2 ||

129:                 _poolExitCollateralRatioBIPS <= minCR * 12 / 10,

132:         require(_poolExitCollateralRatioBIPS <= minCR * 3, ValueTooHigh());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/AgentUpdates.sol)

```solidity
File: ./contracts/assetManager/library/CollateralTypes.sol

32:         require(_data.length >= 2, AtLeastTwoCollateralsRequired());

201:         return bytes32((uint256(_collateralClass) << 160) | uint256(uint160(address(_token))));

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/CollateralTypes.sol)

```solidity
File: ./contracts/assetManager/library/Conversion.sol

136:         uint256 expPlus = _token.decimals + tokenFtsoDec - 5;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Conversion.sol)

```solidity
File: ./contracts/assetManager/library/RedemptionRequests.sol

53:         require(bytes(_redeemerUnderlyingAddressString).length < 128, UnderlyingAddressTooLong());

137:         uint64 blockshift = (uint256(timeshift) * 1000 / settings.averageBlockTimeMS).toUint64();

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/RedemptionRequests.sol)

```solidity
File: ./contracts/assetManager/library/SettingsInitializer.sol

85:         require(_settings.confirmationByOthersAfterSeconds >= 2 hours, MustBeTwoHours());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/SettingsInitializer.sol)

```solidity
File: ./contracts/assetManager/library/SettingsValidators.sol

27:         require(_underlyingBlocks * _averageBlockTimeMS / 1000 <= MAXIMUM_PROOF_WINDOW, ValueTooHigh());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/SettingsValidators.sol)

```solidity
File: ./contracts/assetManager/library/UnderlyingBlockUpdater.sol

45:             _numberOfConfirmations * Globals.getSettings().averageBlockTimeMS / 1000;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/UnderlyingBlockUpdater.sol)

```solidity
File: ./contracts/assetManager/library/data/Agent.sol

221:         bytes32 position = bytes32(uint256(AGENTS_POSITION) ^ (uint256(uint160(_address)) << 64));

237:         return address(uint160((uint256(position) ^ uint256(AGENTS_POSITION)) >> 64));

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/Agent.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPoolToken.sol

211:             cleanupExpiredTimelocks(_from, 10);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPoolToken.sol)

```solidity
File: ./contracts/coreVaultManager/implementation/CoreVaultManager.sol

878:         if (escrowEndTimestamp <= block.timestamp + 12 hours) { // less than 12 hours from now, move to the next day

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/coreVaultManager/implementation/CoreVaultManager.sol)

```solidity
File: ./contracts/fassetToken/implementation/FAsset.sol

75:         _version = 1000;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/implementation/FAsset.sol)

```solidity
File: ./contracts/fassetToken/library/CheckPointHistory.sol

61:             uint256 mid = (max + min + 1) / 2;

191:         require(_value < 2**192, ValueDoesNotFitInOneNineTwoBits());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/library/CheckPointHistory.sol)

```solidity
File: ./contracts/ftso/implementation/FtsoV2PriceStore.sol

115:         submitTrustedPricesWindowSeconds = _votingEpochDurationSeconds / 2; // 45 s

156:             if (trustedPrices.length > 0 && trustedPrices.length >= 4 * trustedProvidersThreshold) {

163:                     priceStore.numberOfSubmits = uint8(trustedPrices.length / 4);

247:         require(_trustedProviders.length < 2**8, TooManyTrustedProviders());

276:             _price *= 10 ** uint256(-decimals);

389:             _price *= 10 ** uint256(-decimals);

403:         assert(length > 0 && length % 4 == 0);

404:         length /= 4;

408:             for (uint256 j = 0; j < 4; j++) {

409:                 price[j] = _prices[i * 4 + j];

429:         uint256 middleIndex = length / 2;

430:         if (length % 2 == 1) {

432:             if (length >= 3) {

433:                 spread = (prices[middleIndex + 1] - prices[middleIndex - 1]) / 2;

437:             _medianPrice = (prices[middleIndex - 1] + prices[middleIndex]) / 2;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/ftso/implementation/FtsoV2PriceStore.sol)

```solidity
File: ./contracts/utils/library/MerkleTree.sol

45:             state.n /= 2;

74:         for (uint256 initialLevel = 0; initialLevel < 2; initialLevel++) {

87:                     levelStack[stackTop - 1] == levelStack[stackTop - 2])

92:                     levelStack[stackTop - 1] == levelStack[stackTop - 2]

95:                     if (hashStack[stackTop - 1] < hashStack[stackTop - 2]) {

96:                         (hashStack[stackTop - 1], hashStack[stackTop - 2]) =

97:                             (hashStack[stackTop - 2], hashStack[stackTop - 1]);

103:                         let ptr := add(hashStack, mul(sub(stackTop, 1), 32))

104:                         mstore(ptr, keccak256(ptr, 64))

113:                     levelStack[stackTop - 2]++;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/utils/library/MerkleTree.sol)

### <a name="NC-5"></a>[NC-5] Control structures do not follow the Solidity Style Guide
See the [control structures](https://docs.soliditylang.org/en/latest/style-guide.html#control-structures) section of the Solidity Style Guide

*Instances (162)*:
```solidity
File: ./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistry.sol

222:         if (whitelist[_address]) return;

228:         if (!whitelist[_address]) return;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistry.sol)

```solidity
File: ./contracts/assetManager/facets/AgentCollateralFacet.sol

145:             Liquidation.endLiquidationIfHealthy(agent);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentCollateralFacet.sol)

```solidity
File: ./contracts/assetManager/facets/AgentSettingsFacet.sol

140:         if (_hash == FEE_BIPS || _hash == POOL_FEE_SHARE_BIPS || _hash == REDEMPTION_POOL_FEE_SHARE_BIPS ||

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentSettingsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/AgentVaultManagementFacet.sol

4: import {IAddressValidity} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

73:         TransactionAttestation.verifyAddressValidity(_addressProof);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentVaultManagementFacet.sol)

```solidity
File: ./contracts/assetManager/facets/ChallengesFacet.sol

4: import {IBalanceDecreasingTransaction} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

62:         TransactionAttestation.verifyBalanceDecreasingTransaction(_payment);

115:         TransactionAttestation.verifyBalanceDecreasingTransaction(_payment1);

116:         TransactionAttestation.verifyBalanceDecreasingTransaction(_payment2);

157:             TransactionAttestation.verifyBalanceDecreasingTransaction(pmi);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/ChallengesFacet.sol)

```solidity
File: ./contracts/assetManager/facets/CollateralReservationsFacet.sol

192:         uint64 timeshift = block.timestamp.toUint64() - state.currentUnderlyingBlockUpdatedAt;

193:         uint64 blockshift = (uint256(timeshift) * 1000 / settings.averageBlockTimeMS).toUint64();

195:             state.currentUnderlyingBlock + blockshift + settings.underlyingBlocksForPayment;

197:             state.currentUnderlyingBlockTimestamp + timeshift + settings.underlyingSecondsForPayment;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/CollateralReservationsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/CoreVaultClientFacet.sol

4: import {IPayment} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

197:         TransactionAttestation.verifyPaymentSuccess(_payment);

219:         UnderlyingBlockUpdater.updateCurrentBlockForVerifiedPayment(_payment);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/CoreVaultClientFacet.sol)

```solidity
File: ./contracts/assetManager/facets/LiquidationFacet.sol

104:         Liquidation.endLiquidationIfHealthy(agent);

122:         Liquidation.endLiquidationIfHealthy(agent);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/LiquidationFacet.sol)

```solidity
File: ./contracts/assetManager/facets/MintingDefaultsFacet.sol

5:     from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

55:         TransactionAttestation.verifyReferencedPaymentNonexistence(_proof);

102:         TransactionAttestation.verifyConfirmedBlockHeightExists(_proof);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/MintingDefaultsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/MintingFacet.sol

4: import {IPayment} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

70:         TransactionAttestation.verifyPaymentSuccess(_payment);

92:         UnderlyingBlockUpdater.updateCurrentBlockForVerifiedPayment(_payment);

126:         TransactionAttestation.verifyPaymentSuccess(_payment);

144:         UnderlyingBlockUpdater.updateCurrentBlockForVerifiedPayment(_payment);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/MintingFacet.sol)

```solidity
File: ./contracts/assetManager/facets/RedemptionConfirmationsFacet.sol

4: import {IPayment} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

71:         TransactionAttestation.verifyPayment(_payment);

139:         Liquidation.endLiquidationIfHealthy(agent);

141:         UnderlyingBlockUpdater.updateCurrentBlockForVerifiedPayment(_payment);

191:         } else if (!request.transferToCoreVault &&

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/RedemptionConfirmationsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/RedemptionDefaultsFacet.sol

5:     from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

56:         TransactionAttestation.verifyReferencedPaymentNonexistence(_proof);

113:             TransactionAttestation.verifyConfirmedBlockHeightExists(_proof);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/RedemptionDefaultsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/RedemptionRequestsFacet.sol

5: import {IAddressValidity} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

203:         assert(!request.transferToCoreVault);   // we have a problem if core vault has invalid address

210:         TransactionAttestation.verifyAddressValidity(_proof);

257:         Liquidation.endLiquidationIfHealthy(agent);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/RedemptionRequestsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/SettingsManagementFacet.sol

11: import {IIFAsset} from "../../fassetToken/interfaces/IIFAsset.sol";

138:     function setFdcVerification(address _value)

147:         settings.fdcVerification = _value;

148:         emit IAssetManagerEvents.ContractChanged("fdcVerification", _value);

156:         IIFAsset fAsset = Globals.getFAsset();

168:         IIFAsset fAsset = Globals.getFAsset();

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/SettingsManagementFacet.sol)

```solidity
File: ./contracts/assetManager/facets/UnderlyingBalanceFacet.sol

4: import {IPayment} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

51:         TransactionAttestation.verifyPaymentSuccess(_payment);

63:         UnderlyingBlockUpdater.updateCurrentBlockForVerifiedPayment(_payment);

112:         TransactionAttestation.verifyPayment(_payment);

136:         UnderlyingBlockUpdater.updateCurrentBlockForVerifiedPayment(_payment);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/UnderlyingBalanceFacet.sol)

```solidity
File: ./contracts/assetManager/facets/UnderlyingTimekeepingFacet.sol

4: import {IConfirmedBlockHeightExists} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/UnderlyingTimekeepingFacet.sol)

```solidity
File: ./contracts/assetManager/library/AgentBacking.sol

82:         if (_ticketValueAMG == 0) return;

105:         if (_agent.dustAMG == _newDustAMG) return;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/AgentBacking.sol)

```solidity
File: ./contracts/assetManager/library/AgentCollateral.sol

236:         if (_valueAMG == 0) return 0;

256:         if (backingTokenWei == 0) return 1e10;    // nothing minted - ~infinite collateral ratio (but avoid overflows)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/AgentCollateral.sol)

```solidity
File: ./contracts/assetManager/library/CoreVaultClient.sol

14: import {IPayment} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/CoreVaultClient.sol)

```solidity
File: ./contracts/assetManager/library/Globals.sol

4: import {IIFAsset} from "../../fassetToken/interfaces/IIFAsset.sol";

45:         returns (IIFAsset)

48:         return IIFAsset(settings.fAsset);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Globals.sol)

```solidity
File: ./contracts/assetManager/library/Liquidation.sol

39:         if (_agent.status == Agent.Status.FULL_LIQUIDATION

49:     function endLiquidationIfHealthy(

55:         if (_agent.status != Agent.Status.LIQUIDATION) return;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Liquidation.sol)

```solidity
File: ./contracts/assetManager/library/Minting.sol

28:         if (_fee == 0) return;

90:         if (mintingCapAMG == 0) return;     // minting cap disabled

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Minting.sol)

```solidity
File: ./contracts/assetManager/library/RedemptionRequests.sol

134:         uint64 timeshift = block.timestamp.toUint64() - state.currentUnderlyingBlockUpdatedAt

137:         uint64 blockshift = (uint256(timeshift) * 1000 / settings.averageBlockTimeMS).toUint64();

139:             state.currentUnderlyingBlock + blockshift + settings.underlyingBlocksForPayment;

141:             state.currentUnderlyingBlockTimestamp + timeshift + settings.underlyingSecondsForPayment;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/RedemptionRequests.sol)

```solidity
File: ./contracts/assetManager/library/SettingsInitializer.sol

60:         require(_settings.fdcVerification != address(0), ZeroAddress());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/SettingsInitializer.sol)

```solidity
File: ./contracts/assetManager/library/TransactionAttestation.sol

4: import {IFdcVerification, IPayment, IBalanceDecreasingTransaction, IConfirmedBlockHeightExists,

6:     from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

27:     function verifyPaymentSuccess(

33:         verifyPayment(_proof);

36:     function verifyPayment(

42:         IFdcVerification fdcVerification = IFdcVerification(_settings.fdcVerification);

44:         require(fdcVerification.verifyPayment(_proof), LegalPaymentNotProven());

47:     function verifyBalanceDecreasingTransaction(

53:         IFdcVerification fdcVerification = IFdcVerification(_settings.fdcVerification);

55:         require(fdcVerification.verifyBalanceDecreasingTransaction(_proof), TransactionNotProven());

58:     function verifyConfirmedBlockHeightExists(

64:         IFdcVerification fdcVerification = IFdcVerification(_settings.fdcVerification);

66:         require(fdcVerification.verifyConfirmedBlockHeightExists(_proof), BlockHeightNotProven());

69:     function verifyReferencedPaymentNonexistence(

75:         IFdcVerification fdcVerification = IFdcVerification(_settings.fdcVerification);

77:         require(fdcVerification.verifyReferencedPaymentNonexistence(_proof), NonPaymentNotProven());

80:     function verifyAddressValidity(

86:         IFdcVerification fdcVerification = IFdcVerification(_settings.fdcVerification);

88:         require(fdcVerification.verifyAddressValidity(_proof), AddressValidityNotProven());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/TransactionAttestation.sol)

```solidity
File: ./contracts/assetManager/library/UnderlyingBlockUpdater.sol

10:     "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

19:         TransactionAttestation.verifyConfirmedBlockHeightExists(_proof);

24:     function updateCurrentBlockForVerifiedPayment(IPayment.Proof calldata _proof)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/UnderlyingBlockUpdater.sol)

```solidity
File: ./contracts/assetManager/library/data/PaymentConfirmations.sol

5:     from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

14:         mapping(bytes32 => bytes32) verifiedPayments;

16:         mapping(uint256 => bytes32) __verifiedPaymentsForDay; // only storage placeholder

18:         uint256 __verifiedPaymentsForDayStart; // only storage placeholder

31:         _recordPaymentVerification(_state, _payment.data.requestBody.transactionId);

46:         _recordPaymentVerification(_state, txKey);

61:         return _state.verifiedPayments[txKey] != 0;

75:     function _recordPaymentVerification(

81:         require(_state.verifiedPayments[_txKey] == 0, PaymentAlreadyConfirmed());

82:         _state.verifiedPayments[_txKey] = _txKey; // any non-zero value is fine

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/PaymentConfirmations.sol)

```solidity
File: ./contracts/assetManager/library/data/PaymentReference.sol

6:     uint256 private constant TYPE_SHIFT = 192;

7:     uint256 private constant TYPE_MASK = ((1 << 64) - 1) << TYPE_SHIFT;

8:     uint256 private constant LOW_BITS_MASK = (1 << TYPE_SHIFT) - 1;

14:     uint256 internal constant MINTING = 0x4642505266410001 << TYPE_SHIFT;

15:     uint256 internal constant REDEMPTION = 0x4642505266410002 << TYPE_SHIFT;

16:     uint256 internal constant ANNOUNCED_WITHDRAWAL = 0x4642505266410003 << TYPE_SHIFT;

17:     uint256 internal constant RETURN_FROM_CORE_VAULT = 0x4642505266410004 << TYPE_SHIFT;

18:     uint256 internal constant REDEMPTION_FROM_CORE_VAULT = 0x4642505266410005 << TYPE_SHIFT;

19:     uint256 internal constant TOPUP = 0x4642505266410011 << TYPE_SHIFT;

20:     uint256 internal constant SELF_MINT = 0x4642505266410012 << TYPE_SHIFT;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/PaymentReference.sol)

```solidity
File: ./contracts/assetManagerController/implementation/AssetManagerController.sol

83:         if (assetManagerIndex[address(_assetManager)] != 0) return;

101:         if (position == 0) return;

227:     function setFdcVerification(IIAssetManager[] memory _assetManagers, address _value)

232:             IISettingsManagement.setFdcVerification.selector, _value);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManagerController/implementation/AssetManagerController.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPool.sol

13: import {IFAsset} from "../../userInterfaces/IFAsset.sol";

29:     using SafeERC20 for IFAsset;

43:     IFAsset public fAsset;              // practically immutable because there is no setter

94:         fAsset = IFAsset(_fAsset);

435:         if (_tokens == 0) return 0;

539:         if (freeFassets == 0) return 0;

624:         if (_fAssets == 0) return;

635:         if (_fAssets == 0) return;

790:         if (_newWNat == wNat) return;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPool.sol)

```solidity
File: ./contracts/coreVaultManager/implementation/CoreVaultManager.sol

10: import {IFdcVerification, IPayment} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

43:     IFdcVerification public fdcVerification;

159:         require(fdcVerification.verifyPayment(_proof), PaymentNotProven());

261:             cancelableTransferRequests[index] = cancelableTransferRequests[index + 1]; // shift left

307:                     cancelableTransferRequests[i] = cancelableTransferRequests[i + 1]; // shift left

339:                     nonCancelableTransferRequests[i] = nonCancelableTransferRequests[i + 1]; // shift left

604:             if(emergencyPauseSenders.add(_addresses[i])) {

811:         fdcVerification = IFdcVerification(

812:             _getContractAddress(_contractNameHashes, _contractAddresses, "FdcVerification"));

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/coreVaultManager/implementation/CoreVaultManager.sol)

```solidity
File: ./contracts/diamond/implementation/Diamond.sol

30:         if(facet == address(0)) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/diamond/implementation/Diamond.sol)

```solidity
File: ./contracts/diamond/library/LibDiamond.sol

64:             if(functionSelectors.length == 0) {

83:         if(_facetAddress == address(0)) {

92:             if(oldFacetAddress != address(0)) {

104:         if(_facetAddress == address(0)) {

112:             if(oldFacetAddress == address(this)) {

115:             if(oldFacetAddress == _facetAddress) {

118:             if(oldFacetAddress == address(0)) {

129:         if(_facetAddress != address(0)) {

136:             if(oldFacetAddressAndSelectorPosition.facetAddress == address(0)) {

141:             if(oldFacetAddressAndSelectorPosition.facetAddress == address(this)) {

184:         if(contractSize == 0) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/diamond/library/LibDiamond.sol)

```solidity
File: ./contracts/fassetToken/implementation/FAsset.sol

11: import {IIFAsset} from "../interfaces/IIFAsset.sol";

16: import {IFAsset} from "../../userInterfaces/IFAsset.sol";

229:             || _interfaceId == type(IFAsset).interfaceId

230:             || _interfaceId == type(IIFAsset).interfaceId

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/implementation/FAsset.sol)

```solidity
File: ./contracts/fassetToken/library/CheckPointHistory.sol

87:         if (historyCount == 0) return 0;

117:         if (historyCount == 0) return 0;

171:         if (_cleanupBlockNumber == 0) return 0;   // optimization for when cleaning is not enabled

173:         if (length == 0) return 0;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/library/CheckPointHistory.sol)

```solidity
File: ./contracts/fassetToken/library/CheckPointsByAddress.sol

37:         if (_amount == 0) return;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/library/CheckPointsByAddress.sol)

```solidity
File: ./contracts/ftso/implementation/FtsoV2PriceStore.sol

147:             require(proof.proof.verifyCalldata(merkleRoot, feedHash), MerkleProofInvalid());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/ftso/implementation/FtsoV2PriceStore.sol)

```solidity
File: ./contracts/userInterfaces/IAssetManager.sol

6:     from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAssetManager.sol)

```solidity
File: ./contracts/userInterfaces/ICoreVaultClient.sol

4: import {IPayment} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/ICoreVaultClient.sol)

```solidity
File: ./contracts/userInterfaces/ICoreVaultManager.sol

4: import {IPayment} from "@flarenetwork/flare-periphery-contracts/flare/IFdcVerification.sol";

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/ICoreVaultManager.sol)

```solidity
File: ./contracts/userInterfaces/data/AssetManagerSettings.sol

53:         address fdcVerification;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/AssetManagerSettings.sol)

```solidity
File: ./contracts/utils/library/MerkleTree.sol

90:                 if (

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/utils/library/MerkleTree.sol)

```solidity
File: ./contracts/utils/library/SafePct.sol

27:         if (x == 0) return 0;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/utils/library/SafePct.sol)

### <a name="NC-6"></a>[NC-6] Critical Changes Should Use Two-step Procedure
The critical procedures should be two step process.

See similar findings in previous Code4rena contests for reference: <https://code4rena.com/reports/2022-06-illuminate/#2-critical-changes-should-use-two-step-procedure>

**Recommended Mitigation Steps**

Lack of two-step procedure for critical operations leaves them error-prone. Consider adding two step procedure on the critical functions.

*Instances (1)*:
```solidity
File: ./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistry.sol

81:     function setWorkAddress(address _ownerWorkAddress)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistry.sol)

### <a name="NC-7"></a>[NC-7] Functions should not be longer than 50 lines
Overly complex code can make understanding functionality more difficult, try to further modularize your code to ensure readability

*Instances (382)*:
```solidity
File: ./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistry.sol

38:     function initialize(IGovernanceSettings _governanceSettings, address _initialGovernance) external {

42:     function revokeAddress(address _address) external onlyGovernanceOrManager {

46:     function setManager(address _manager) external onlyGovernance {

81:     function setWorkAddress(address _ownerWorkAddress)

105:     function setAgentName(address _managementAddress, string memory _name)

118:     function setAgentDescription(address _managementAddress, string memory _description)

131:     function setAgentIconUrl(address _managementAddress, string memory _iconUrl)

144:     function setAgentTermsOfUseUrl(address _managementAddress, string memory _touUrl)

167:     function getAgentDescription(address _managementAddress)

178:     function getAgentIconUrl(address _managementAddress)

189:     function getAgentTermsOfUseUrl(address _managementAddress)

199:     function getWorkAddress(address _managementAddress)

209:     function getManagementAddress(address _workAddress)

216:     function isWhitelisted(address _address) public view override returns (bool) {

220:     function _addAddressToWhitelist(address _address) internal {

227:     function _removeAddressFromWhitelist(address _address) internal {

247:     function _emitDataChanged(address _managementAddress) private {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistry.sol)

```solidity
File: ./contracts/agentVault/implementation/AgentVault.sol

49:     function initialize(IIAssetManager _assetManager) public {

63:     function withdrawPoolFees(uint256 _amount, address _recipient)

70:     function redeemCollateralPoolTokens(uint256 _amount, address payable _recipient)

81:     function depositCollateral(IERC20 _token, uint256 _amount)

99:     function withdrawCollateral(IERC20 _token, uint256 _amount, address _recipient)

115:     function transferExternalToken(IERC20 _token, uint256 _amount)

140:     function payout(IERC20 _token, address _recipient, uint256 _amount)

177:     function implementation() external view returns (address) {

185:     function _authorizeUpgrade(address /* _newImplementation */)

193:     function _validateToken(IERC20 _token) private view {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentVault/implementation/AgentVault.sol)

```solidity
File: ./contracts/assetManager/facets/AgentInfoFacet.sol

48:     function isPoolTokenSuffixReserved(string memory _suffix)

134:     function getAgentVaultCollateralToken(address _agentVault)

141:     function getAgentFullVaultCollateral(address _agentVault)

148:     function getAgentFullPoolCollateral(address _agentVault)

155:     function getAgentLiquidationFactorsAndMaxAmount(address _agentVault)

168:     function getAgentMinPoolCollateralRatioBIPS(address _agentVault)

175:     function getAgentMinVaultCollateralRatioBIPS(address _agentVault)

182:     function _getFullCollateral(address _agentVault, Collateral.Kind _kind)

191:     function _getMinCollateralRatioBIPS(address _agentVault, Collateral.Kind _kind)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentInfoFacet.sol)

```solidity
File: ./contracts/assetManager/facets/AgentPingFacet.sol

13:     function agentPing(address _agentVault, uint256 _query) external {

20:     function agentPingResponse(address _agentVault, uint256 _query, string memory _response)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentPingFacet.sol)

```solidity
File: ./contracts/assetManager/facets/AgentSettingsFacet.sol

138:     function _getTimelock(bytes32 _hash) private view returns (uint64) {

150:     function _getAndCheckHash(string memory _name) private pure returns (bytes32) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentSettingsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/AgentVaultAndPoolSupportFacet.sol

36:     function isLockedVaultToken(address _agentVault, IERC20 _token)

54:     function getFAssetsBackedByPool(address _agentVault)

62:     function isAgentVaultOwner(address _agentVault, address _address)

70:     function getWorkAddress(address _managementAddress)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentVaultAndPoolSupportFacet.sol)

```solidity
File: ./contracts/assetManager/facets/AgentVaultManagementFacet.sol

230:     function _upgradeAgentVaultAndPool(address _agentVault)

282:     function _reserveAndValidatePoolTokenSuffix(string memory _suffix)

330:     function _getManagementAddress(address _ownerAddress)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentVaultManagementFacet.sol)

```solidity
File: ./contracts/assetManager/facets/AssetManagerBase.sol

36:     function _checkOnlyAssetManagerController() private view {

45:     function _checkEmergencyPauseNotActive() private view {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AssetManagerBase.sol)

```solidity
File: ./contracts/assetManager/facets/ChallengesFacet.sol

192:     function _validateAgentStatus(Agent.State storage _agent)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/ChallengesFacet.sol)

```solidity
File: ./contracts/assetManager/facets/CoreVaultClientSettingsFacet.sol

101:     function setCoreVaultTransferTimeExtensionSeconds(

164:     function getCoreVaultTransferTimeExtensionSeconds()

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/CoreVaultClientSettingsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/EmergencyPauseFacet.sol

18:     function emergencyPause(bool _byGovernance, uint256 _duration)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/EmergencyPauseFacet.sol)

```solidity
File: ./contracts/assetManager/facets/EmergencyPauseTransfersFacet.sol

18:     function emergencyPauseTransfers(bool _byGovernance, uint256 _duration)

52:     function resetEmergencyPauseTransfersTotalDuration()

84:     function _transfersPaused() private view returns (bool) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/EmergencyPauseTransfersFacet.sol)

```solidity
File: ./contracts/assetManager/facets/RedemptionTimeExtensionFacet.sol

30:     function initRedemptionTimeExtensionFacet(uint256 _redemptionPaymentExtensionSeconds)

41:     function setRedemptionPaymentExtensionSeconds(uint256 _value)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/RedemptionTimeExtensionFacet.sol)

```solidity
File: ./contracts/assetManager/facets/SettingsManagementFacet.sol

52:     function updateSystemContracts(address _controller, IWNat _wNat)

112:     function setCollateralPoolTokenFactory(address _value)

163:     function setCleanupBlockNumberManager(address _value)

175:     function upgradeFAssetImplementation(address _value, bytes memory callData)

192:     function setTimeForPayment(uint256 _underlyingBlocks, uint256 _underlyingSeconds)

209:     function setPaymentChallengeReward(uint256 _rewardNATWei, uint256 _rewardBIPS)

227:     function setMinUpdateRepeatTimeSeconds(uint256 _value)

259:     function setMaxTrustedPriceAgeSeconds(uint256 _value)

274:     function setCollateralReservationFeeBips(uint256 _value)

306:     function setRedemptionDefaultFactorVaultCollateralBIPS(uint256 _value)

324:     function setConfirmationByOthersAfterSeconds(uint256 _value)

337:     function setConfirmationByOthersRewardUSD5(uint256 _value)

367:     function setWithdrawalOrDestroyWaitMinSeconds(uint256 _value)

382:     function setAttestationWindowSeconds(uint256 _value)

410:     function setMintingPoolHoldingsRequiredBIPS(uint256 _value)

436:     function setTokenInvalidationTimeMinSeconds(uint256 _value)

448:     function setVaultCollateralBuyForFlareFactorBIPS(uint256 _value)

461:     function setAgentExitAvailableTimelockSeconds(uint256 _value)

474:     function setAgentFeeChangeTimelockSeconds(uint256 _value)

487:     function setAgentMintingCRChangeTimelockSeconds(uint256 _value)

500:     function setPoolExitCRChangeTimelockSeconds(uint256 _value)

513:     function setAgentTimelockedOperationWindowSeconds(uint256 _value)

526:     function setCollateralPoolTokenTimelockSeconds(uint256 _value)

539:     function setLiquidationStepSeconds(uint256 _stepSeconds)

577:     function setMaxEmergencyPauseDurationSeconds(uint256 _value)

593:     function setEmergencyPauseDurationResetAfterSeconds(uint256 _value)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/SettingsManagementFacet.sol)

```solidity
File: ./contracts/assetManager/facets/SystemInfoFacet.sol

24:     function controllerAttached() external view  returns (bool) {

135:     function _convertCollateralReservationStatus(CollateralReservation.Status _status)

151:     function _convertRedemptionStatus(Redemption.Status _status)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/SystemInfoFacet.sol)

```solidity
File: ./contracts/assetManager/library/Agents.sol

77:     function getWorkAddress(Agent.State storage _agent)

84:     function getOwnerPayAddress(Agent.State storage _agent)

143:     function getVaultCollateralToken(Agent.State storage _agent)

151:     function getVaultCollateral(Agent.State storage _agent)

159:     function convertUSD5ToVaultCollateralWei(Agent.State storage _agent, uint256 _amountUSD5)

174:     function getPoolCollateral(Agent.State storage _agent)

182:     function getCollateral(Agent.State storage _agent, Collateral.Kind _kind)

195:     function collateralUnderwater(Agent.State storage _agent, Collateral.Kind _kind)

209:     function withdrawalAnnouncement(Agent.State storage _agent, Collateral.Kind _kind)

219:     function totalBackedAMG(Agent.State storage _agent)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Agents.sol)

```solidity
File: ./contracts/assetManager/library/CollateralTypes.sol

123:     function isValid(CollateralTypeInt.Data storage _token)

130:     function _add(CollateralType.Data memory _data) private returns (uint256) {

170:     function _setPoolCollateralTypeIndex(uint256 _index) private {

177:     function _getInfo(CollateralTypeInt.Data storage token)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/CollateralTypes.sol)

```solidity
File: ./contracts/assetManager/library/Conversion.sol

161:     function readFtsoPrice(string memory _symbol, bool _fromTrustedProviders)

194:     function convertAmgToTokenWei(uint256 _valueAMG, uint256 _amgToTokenWeiPrice) internal pure returns (uint256) {

198:     function convertTokenWeiToAMG(uint256 _valueNATWei, uint256 _amgToTokenWeiPrice) internal pure returns (uint256) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Conversion.sol)

```solidity
File: ./contracts/assetManager/library/CoreVaultClient.sol

167:     function _minimumRemainingAfterTransferForCollateralAMG(

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/CoreVaultClient.sol)

```solidity
File: ./contracts/assetManager/library/RedemptionQueueInfo.sol

17:     function redemptionQueue(uint256 _firstRedemptionTicketId, uint256 _pageSize)

24:     function agentRedemptionQueue(address _agentVault, uint256 _firstRedemptionTicketId, uint256 _pageSize)

33:     function _getRedemptionQueue(address _agentVault, uint256 _firstRedemptionTicketId, uint256 _pageSize)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/RedemptionQueueInfo.sol)

```solidity
File: ./contracts/assetManager/library/RedemptionRequests.sol

126:     function _lastPaymentBlock(address _agentVault, uint64 _additionalPaymentTime)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/RedemptionRequests.sol)

```solidity
File: ./contracts/assetManager/library/Redemptions.sol

179:     function isOpen(Redemption.Request storage _request)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Redemptions.sol)

```solidity
File: ./contracts/assetManager/library/SettingsUpdater.sol

17:     function checkEnoughTimeSinceLastUpdate() internal {

21:     function checkEnoughTimeSinceLastUpdate(bytes32 _action) internal {

30:     function _getUpdaterState() private pure returns (UpdaterState storage _state) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/SettingsUpdater.sol)

```solidity
File: ./contracts/assetManager/library/UnderlyingBalance.sol

49:     function requiredUnderlyingUBA(Agent.State storage _agent)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/UnderlyingBalance.sol)

```solidity
File: ./contracts/assetManager/library/UnderlyingBlockUpdater.sol

16:     function updateCurrentBlock(IConfirmedBlockHeightExists.Proof calldata _proof)

24:     function updateCurrentBlockForVerifiedPayment(IPayment.Proof calldata _proof)

34:     function updateCurrentBlock(uint64 _blockNumber, uint64 _blockTimestamp, uint64 _numberOfConfirmations)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/UnderlyingBlockUpdater.sol)

```solidity
File: ./contracts/assetManager/library/data/AssetManagerState.sol

113:     function get() internal pure returns (AssetManagerState.State storage _state) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/AssetManagerState.sol)

```solidity
File: ./contracts/assetManager/library/data/PaymentConfirmations.sol

68:     function transactionKey(bytes32 _underlyingSourceAddressHash, bytes32 _transactionHash)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/PaymentConfirmations.sol)

```solidity
File: ./contracts/assetManager/library/data/PaymentReference.sol

24:     function minting(uint256 _id) internal pure returns (bytes32) {

29:     function redemption(uint256 _id) internal pure returns (bytes32) {

34:     function announcedWithdrawal(uint256 _id) internal pure returns (bytes32) {

39:     function returnFromCoreVault(uint256 _id) internal pure returns (bytes32) {

44:     function redemptionFromCoreVault(uint256 _id) internal pure returns (bytes32) {

49:     function topup(address _agentVault) internal pure returns (bytes32) {

53:     function selfMint(address _agentVault) internal pure returns (bytes32) {

59:     function isValid(bytes32 _reference, uint256 _type) internal pure returns (bool) {

66:     function decodeId(bytes32 _reference) internal pure returns (uint256) {

70:     function randomizedIdSkip() internal view returns (uint64) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/PaymentReference.sol)

```solidity
File: ./contracts/assetManager/library/data/RedemptionQueue.sol

112:     function getTicket(State storage _state, uint64 _id) internal view returns (Ticket storage) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/RedemptionQueue.sol)

```solidity
File: ./contracts/assetManager/library/data/RedemptionTimeExtension.sol

29:     function extendTimeForRedemption(address _agentVault)

41:     function setRedemptionPaymentExtensionSeconds(uint256 _value)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/RedemptionTimeExtension.sol)

```solidity
File: ./contracts/assetManagerController/implementation/AssetManagerController.sol

79:     function addAssetManager(IIAssetManager _assetManager)

96:     function removeAssetManager(IIAssetManager _assetManager)

134:     function assetManagerExists(address _assetManager)

158:     function upgradeToAndCall(address newImplementation, bytes memory data)

170:     function _authorizeUpgrade(address /* _newImplementation */)

179:     function setAgentOwnerRegistry(IIAssetManager[] memory _assetManagers, address _value)

187:     function setAgentVaultFactory(IIAssetManager[] memory _assetManagers, address _value)

195:     function setCollateralPoolFactory(IIAssetManager[] memory _assetManagers, address _value)

203:     function setCollateralPoolTokenFactory(IIAssetManager[] memory _assetManagers, address _value)

211:     function upgradeAgentVaultsAndPools(IIAssetManager[] memory _assetManagers, uint256 _start, uint256 _end)

219:     function setPriceReader(IIAssetManager[] memory _assetManagers, address _value)

227:     function setFdcVerification(IIAssetManager[] memory _assetManagers, address _value)

235:     function setCleanerContract(IIAssetManager[] memory _assetManagers, address _value)

243:     function setCleanupBlockNumberManager(IIAssetManager[] memory _assetManagers, address _value)

264:     function setMinUpdateRepeatTimeSeconds(IIAssetManager[] memory _assetManagers, uint256 _value)

272:     function setLotSizeAmg(IIAssetManager[] memory _assetManagers, uint256 _value)

304:     function setMaxTrustedPriceAgeSeconds(IIAssetManager[] memory _assetManagers, uint256 _value)

312:     function setCollateralReservationFeeBips(IIAssetManager[] memory _assetManagers, uint256 _value)

320:     function setRedemptionFeeBips(IIAssetManager[] memory _assetManagers, uint256 _value)

328:     function setRedemptionDefaultFactorVaultCollateralBIPS(IIAssetManager[] memory _assetManagers, uint256 _value)

336:     function setConfirmationByOthersAfterSeconds(IIAssetManager[] memory _assetManagers, uint256 _value)

344:     function setConfirmationByOthersRewardUSD5(IIAssetManager[] memory _assetManagers, uint256 _value)

352:     function setMaxRedeemedTickets(IIAssetManager[] memory _assetManagers, uint256 _value)

360:     function setWithdrawalOrDestroyWaitMinSeconds(IIAssetManager[] memory _assetManagers, uint256 _value)

368:     function setAttestationWindowSeconds(IIAssetManager[] memory _assetManagers, uint256 _value)

376:     function setAverageBlockTimeMS(IIAssetManager[] memory _assetManagers, uint256 _value)

384:     function setMintingPoolHoldingsRequiredBIPS(IIAssetManager[] memory _assetManagers, uint256 _value)

392:     function setMintingCapAmg(IIAssetManager[] memory _assetManagers, uint256 _value)

400:     function setTokenInvalidationTimeMinSeconds(IIAssetManager[] memory _assetManagers, uint256 _value)

408:     function setVaultCollateralBuyForFlareFactorBIPS(IIAssetManager[] memory _assetManagers, uint256 _value)

416:     function setAgentExitAvailableTimelockSeconds(IIAssetManager[] memory _assetManagers, uint256 _value)

424:     function setAgentFeeChangeTimelockSeconds(IIAssetManager[] memory _assetManagers, uint256 _value)

432:     function setAgentMintingCRChangeTimelockSeconds(IIAssetManager[] memory _assetManagers, uint256 _value)

440:     function setPoolExitCRChangeTimelockSeconds(IIAssetManager[] memory _assetManagers, uint256 _value)

448:     function setAgentTimelockedOperationWindowSeconds(IIAssetManager[] memory _assetManagers, uint256 _value)

456:     function setCollateralPoolTokenTimelockSeconds(IIAssetManager[] memory _assetManagers, uint256 _value)

464:     function setLiquidationStepSeconds(IIAssetManager[] memory _assetManagers, uint256 _value)

545:     function pauseMinting(IIAssetManager[] calldata _assetManagers)

555:     function unpauseMinting(IIAssetManager[] calldata _assetManagers)

589:     function updateContracts(IIAssetManager[] calldata _assetManagers)

643:     function emergencyPause(IIAssetManager[] memory _assetManagers, uint256 _duration)

653:     function emergencyPauseTransfers(IIAssetManager[] memory _assetManagers, uint256 _duration)

663:     function resetEmergencyPauseTotalDuration(IIAssetManager[] memory _assetManagers)

673:     function addEmergencyPauseSender(address _address)

680:     function removeEmergencyPauseSender(address _address)

687:     function setMaxEmergencyPauseDurationSeconds(IIAssetManager[] memory _assetManagers, uint256 _value)

695:     function setEmergencyPauseDurationResetAfterSeconds(IIAssetManager[] memory _assetManagers, uint256 _value)

706:     function _setValueOnManagers(IIAssetManager[] memory _assetManagers, bytes4 _selector, address _value) private {

710:     function _setValueOnManagers(IIAssetManager[] memory _assetManagers, bytes4 _selector, uint256 _value) private {

714:     function _callOnManagers(IIAssetManager[] memory _assetManagers, bytes memory _calldata) private {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManagerController/implementation/AssetManagerController.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPool.sol

116:     function poolToken() external view returns (ICollateralPoolToken) {

120:     function setExitCollateralRatioBIPS(uint256 _exitCollateralRatioBIPS)

180:     function exitTo(uint256 _tokenShare, address payable _recipient)

189:     function _exitTo(uint256 _tokenShare, address payable _recipient)

320:     function fAssetRequiredForSelfCloseExit(uint256 _tokenAmountWei)

346:     function withdrawFeesTo(uint256 _fAssets, address _recipient)

359:     function _withdrawFeesTo(uint256 _fAssets, address _recipient)

621:     function _createFAssetFeeDebt(address _account, uint256 _fAssets)

632:     function _deleteFAssetFeeDebt(address _account, uint256 _fAssets)

805:     function delegate(address _to, uint256 _bips) external onlyAgent {

813:     function delegateGovernance(address _to) external onlyAgent {

817:     function undelegateGovernance() external onlyAgent {

873:     function implementation() external view returns (address) {

881:     function _authorizeUpgrade(address /* _newImplementation */)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPool.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPoolFactory.sol

41:     function upgradeInitCall(address /* _proxy */) external pure override returns (bytes memory) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPoolFactory.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPoolToken.sol

80:     function name() public view virtual override returns (string memory) {

88:     function symbol() public view virtual override returns (string memory) {

266:     function implementation() external view returns (address) {

274:     function _authorizeUpgrade(address /* _newImplementation */)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPoolToken.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPoolTokenFactory.sol

21:     function create(IICollateralPool _pool, string memory _systemSuffix, string memory _agentSuffix)

36:     function upgradeInitCall(address /* _proxy */) external pure override returns (bytes memory) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPoolTokenFactory.sol)

```solidity
File: ./contracts/coreVaultManager/implementation/CoreVaultManager.sol

271:     function processEscrows(uint256 _maxCount) external returns (bool) {

278:     function triggerInstructions() external notPaused returns (uint256 _numberOfInstructions) {

599:     function addEmergencyPauseSenders(address[] calldata _addresses)

615:     function removeEmergencyPauseSenders(address[] calldata _addresses)

639:     function unpause() external onlyImmediateGovernance {

649:     function triggerCustomInstructions(bytes32 _instructionsHash) external onlyImmediateGovernance {

675:     function getAllowedDestinationAddresses() external view returns (string[] memory) {

682:     function isDestinationAddressAllowed(string memory _address) external view returns (bool) {

689:     function getTriggeringAccounts() external view returns (address[] memory) {

696:     function getUnprocessedEscrows() external view returns (Escrow[] memory _unprocessedEscrows) {

707:     function getEscrowsCount() external view returns (uint256) {

714:     function getEscrowByIndex(uint256 _index) external view returns (Escrow memory) {

721:     function getEscrowByPreimageHash(bytes32 _preimageHash) external view returns (Escrow memory) {

729:     function getUnusedPreimageHashes() external view returns (bytes32[] memory) {

741:     function getPreimageHashesCount() external view returns (uint256) {

748:     function getPreimageHash(uint256 _index) external view returns (bytes32) {

755:     function getCancelableTransferRequests() external view returns (TransferRequest[] memory _transferRequests) {

765:     function getNonCancelableTransferRequests() external view returns (TransferRequest[] memory _transferRequests) {

775:     function totalRequestAmountWithFee() public view returns (uint256) {

783:     function getEmergencyPauseSenders() external view returns (address[] memory) {

820:     function _processEscrows(uint256 _maxCount) internal returns (bool _allProcessed) {

856:     function _getEscrow(uint256 _index) internal view returns (Escrow storage) {

865:     function _getNextEscrowEndTimestamp() internal view returns (uint64) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/coreVaultManager/implementation/CoreVaultManager.sol)

```solidity
File: ./contracts/diamond/facets/DiamondLoupeFacet.sol

48:                     facets_[facetIndex].functionSelectors[numFacetSelectors[facetIndex]] = selector;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/diamond/facets/DiamondLoupeFacet.sol)

```solidity
File: ./contracts/diamond/library/LibDiamond.sol

20: error CannotAddFunctionToDiamondThatAlreadyExists(bytes4 _selector);

21: error CannotReplaceFunctionsFromFacetWithZeroAddress(bytes4[] _selectors);

23: error CannotReplaceFunctionWithTheSameFunctionFromTheSameFacet(bytes4 _selector);

28: error InitializationFunctionReverted(address _initializationContractAddress, bytes _calldata);

48:     function diamondStorage() internal pure returns (DiamondStorage storage ds) {

62:             bytes4[] memory functionSelectors = _diamondCut[facetIndex].functionSelectors;

82:     function addFunctions(address _facetAddress, bytes4[] memory _functionSelectors) internal {

102:     function replaceFunctions(address _facetAddress, bytes4[] memory _functionSelectors) internal {

105:             revert CannotReplaceFunctionsFromFacetWithZeroAddress(_functionSelectors);

116:                 revert CannotReplaceFunctionWithTheSameFunctionFromTheSameFacet(selector);

126:     function removeFunctions(address _facetAddress, bytes4[] memory _functionSelectors) internal {

158:     function initializeDiamondCut(address _init, bytes memory _calldata) internal {

179:     function enforceHasContractCode(address _contract, string memory _errorMessage) internal view {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/diamond/library/LibDiamond.sol)

```solidity
File: ./contracts/fassetToken/implementation/CheckPointable.sol

63:     function balanceOfAt(address _owner, uint256 _blockNumber)

76:     function _burnForAtNow(address _owner, uint256 _amount) internal virtual {

89:     function _mintForAtNow(address _owner, uint256 _amount) internal virtual {

116:     function _transmitAtNow(address _from, address _to, uint256 _amount) internal virtual {

125:     function _setCleanupBlockNumber(uint256 _blockNumber) internal {

134:     function _cleanupBlockNumber() internal view returns (uint256) {

144:     function _updateBalanceHistoryAtTransfer(address _from, address _to, uint256 _amount) internal virtual {

162:     function _setCleanerContract(address _cleanerContract) internal {

173:     function balanceHistoryCleanup(address _owner, uint256 _count) external onlyCleaner returns (uint256) {

183:     function totalSupplyHistoryCleanup(uint256 _count) external onlyCleaner returns (uint256) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/implementation/CheckPointable.sol)

```solidity
File: ./contracts/fassetToken/implementation/FAsset.sol

142:     function name() public view virtual override(ERC20, IERC20Metadata) returns (string memory) {

149:     function symbol() public view virtual override(ERC20, IERC20Metadata) returns (string memory) {

155:     function decimals() public view virtual override(ERC20, IERC20Metadata) returns (uint8) {

166:     function setCleanupBlockNumber(uint256 _blockNumber)

186:     function setCleanerContract(address _cleanerContract)

197:     function setCleanupBlockNumberManager(address _cleanupBlockNumberManager)

204:     function _beforeTokenTransfer(address _from, address _to, uint256 _amount)

235:     function _approve(address _owner, address _spender, uint256 _amount)

244:     function implementation() external view returns (address) {

252:     function _authorizeUpgrade(address /* _newImplementation */)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/implementation/FAsset.sol)

```solidity
File: ./contracts/fassetToken/library/CheckPointHistory.sol

114:     function valueAtNow(CheckPointHistoryState storage _self) internal view returns (uint256 _value) {

190:     function _toUint192(uint256 _value) internal pure returns (uint192) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/library/CheckPointHistory.sol)

```solidity
File: ./contracts/fassetToken/library/CheckPointsByAddress.sol

84:     function valueOfAtNow(CheckPointsByAddressState storage _self, address _owner) internal view returns (uint256) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/library/CheckPointsByAddress.sol)

```solidity
File: ./contracts/flareSmartContracts/implementation/AddressUpdatable.sol

25:     function getAddressUpdater() public view returns (address _addressUpdater) {

82:     function setAddressUpdaterValue(address _addressUpdater) internal {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/flareSmartContracts/implementation/AddressUpdatable.sol)

```solidity
File: ./contracts/ftso/implementation/FtsoV2PriceStore.sol

123:     function publishPrices(FeedWithProof[] calldata _proofs) external {

175:     function submitTrustedPrices(uint32 _votingRoundId, TrustedProviderFeed[] calldata _feeds) external {

285:     function getPriceFromTrustedProviders(string memory _symbol)

298:     function getPriceFromTrustedProvidersWithQuality(string memory _symbol)

312:     function getFeedIds() external view returns (bytes21[] memory) {

319:     function getFeedIdsWithDecimals() external view returns (bytes21[] memory _feedIds, int8[] memory _decimals) {

330:     function getSymbols() external view returns (string[] memory _symbols) {

340:     function getFeedId(string memory _symbol) external view returns (bytes21) {

347:     function getTrustedProviders() external view returns (address[] memory) {

366:     function _getPreviousVotingEpochId() internal view returns(uint32) {

373:     function _getEndTimestamp(uint256 _votingEpochId) internal view returns(uint256) {

380:     function _getPriceFromTrustedProviders(PriceStore storage _feed)

401:     function _calculateMedian(bytes memory _prices) internal view returns (uint256 _medianPrice, bool _priceOk) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/ftso/implementation/FtsoV2PriceStore.sol)

```solidity
File: ./contracts/governance/implementation/GovernedBase.sol

59:     function executeGovernanceCall(bytes calldata _encodedCall) external override {

80:     function cancelGovernanceCall(bytes calldata _encodedCall) external override onlyImmediateGovernance {

93:     function switchToProductionMode() external onlyImmediateGovernance {

104:     function initialise(IGovernanceSettings _governanceSettings, address _initialGovernance) internal virtual {

118:     function governanceSettings() public view returns (IGovernanceSettings) {

125:     function productionMode() public view returns (bool) {

132:     function governance() public view returns (address) {

140:     function isExecutor(address _address) public view returns (bool) {

159:     function _recordTimelockedCall(bytes calldata _encodedCall, uint256 _minimumTimelock) private {

172:     function _timeToExecute() private view returns (bool) {

181:     function _governedState() private pure returns (GovernedState storage _state) {

189:     function _passReturnOrRevert(bool _success) private pure {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/governance/implementation/GovernedBase.sol)

```solidity
File: ./contracts/governance/implementation/GovernedUUPSProxyImplementation.sol

34:     function upgradeToAndCall(address newImplementation, bytes memory data)

46:     function _authorizeUpgrade(address  /* _newImplementation */)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/governance/implementation/GovernedUUPSProxyImplementation.sol)

```solidity
File: ./contracts/userInterfaces/IAgentAlwaysAllowedMinters.sol

6:     function addAlwaysAllowedMinterForAgent(address _agentVault, address _minter)

9:     function removeAlwaysAllowedMinterForAgent(address _agentVault, address _minter)

12:     function alwaysAllowedMintersForAgent(address _agentVault)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAgentAlwaysAllowedMinters.sol)

```solidity
File: ./contracts/userInterfaces/IAgentOwnerRegistry.sol

36:     function isWhitelisted(address _address) external view returns (bool);

50:     function getAgentDescription(address _managementAddress)

58:     function getAgentIconUrl(address _managementAddress)

66:     function getAgentTermsOfUseUrl(address _managementAddress)

73:     function getWorkAddress(address _managementAddress)

80:     function getManagementAddress(address _workAddress)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAgentOwnerRegistry.sol)

```solidity
File: ./contracts/userInterfaces/IAgentVault.sol

23:     function depositCollateral(IERC20 _token, uint256 _amount) external;

30:     function updateCollateral(IERC20 _token) external;

38:     function withdrawCollateral(IERC20 _token, uint256 _amount, address _recipient) external;

46:     function transferExternalToken(IERC20 _token, uint256 _amount) external;

53:     function buyCollateralPoolTokens() external payable;

60:     function withdrawPoolFees(uint256 _amount, address _recipient) external;

70:     function redeemCollateralPoolTokens(uint256 _amount, address payable _recipient) external;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAgentVault.sol)

```solidity
File: ./contracts/userInterfaces/IAssetManager.sol

184:     function getCollateralType(CollateralType.Class _collateralClass, IERC20 _token)

412:     function getAllAgents(uint256 _start, uint256 _end)

434:     function getAgentSetting(address _agentVault, string memory _name)

455:     function getAgentVaultCollateralToken(address _agentVault)

462:     function getAgentFullVaultCollateral(address _agentVault)

469:     function getAgentFullPoolCollateral(address _agentVault)

477:     function getAgentLiquidationFactorsAndMaxAmount(address _agentVault)

488:     function getAgentMinPoolCollateralRatioBIPS(address _agentVault)

495:     function getAgentMinVaultCollateralRatioBIPS(address _agentVault)

538:     function getAvailableAgentsList(uint256 _start, uint256 _end)

551:     function getAvailableAgentsDetailedList(uint256 _start, uint256 _end)

602:     function collateralReservationInfo(uint256 _collateralReservationId)

781:     function redemptionRequestInfo(uint256 _redemptionRequestId)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAssetManager.sol)

```solidity
File: ./contracts/userInterfaces/IAssetManagerController.sol

19:     function assetManagerExists(address _assetManager)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAssetManagerController.sol)

```solidity
File: ./contracts/userInterfaces/ICollateralPool.sol

140:     function exitTo(uint256 _tokenShare, address payable _recipient)

179:     function withdrawFeesTo(uint256 _amount, address _recipient) external;

185:     function payFAssetFeeDebt(uint256 _fassets) external;

209:     function delegate(address _to, uint256 _bips) external;

298:     function fAssetRequiredForSelfCloseExit(uint256 _tokenAmountWei)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/ICollateralPool.sol)

```solidity
File: ./contracts/userInterfaces/ICoreVaultClient.sol

80:     function transferToCoreVault(address _agentVault, uint256 _amountUBA)

93:     function requestReturnFromCoreVault(address _agentVault, uint256 _lots)

100:     function cancelReturnFromCoreVault(address _agentVault)

109:     function confirmReturnFromCoreVault(IPayment.Proof calldata _payment, address _agentVault)

121:     function redeemFromCoreVault(uint256 _lots, string memory _redeemerUnderlyingAddress)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/ICoreVaultClient.sol)

```solidity
File: ./contracts/userInterfaces/ICoreVaultClientSettings.sol

8:     function setCoreVaultManager(address _coreVaultManager)

11:     function setCoreVaultNativeAddress(address payable _nativeAddress)

14:     function setCoreVaultTransferTimeExtensionSeconds(uint256 _transferTimeExtensionSeconds)

17:     function setCoreVaultRedemptionFeeBIPS(uint256 _redemptionFeeBIPS)

20:     function setCoreVaultMinimumAmountLeftBIPS(uint256 _minimumAmountLeftBIPS)

23:     function setCoreVaultMinimumRedeemLots(uint256 _minimumRedeemLots)

34:     function getCoreVaultTransferTimeExtensionSeconds()

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/ICoreVaultClientSettings.sol)

```solidity
File: ./contracts/userInterfaces/ICoreVaultManager.sol

151:     function confirmPayment(IPayment.Proof calldata _proof) external;

164:     function processEscrows(uint256 _maxCount) external returns (bool);

172:     function triggerInstructions() external returns (uint256 _numberOfInstructions);

178:     function availableFunds() external view returns (uint128);

184:     function escrowedFunds() external view returns (uint128);

189:     function totalRequestAmountWithFee() external view returns (uint256);

201:     function getTriggeringAccounts() external view returns (address[] memory);

224:     function getAllowedDestinationAddresses() external view returns (string[] memory);

231:     function isDestinationAddressAllowed(string memory _address) external view returns (bool);

237:     function coreVaultAddress() external view returns (string memory);

243:     function coreVaultAddressHash() external view returns (bytes32);

248:     function assetManager() external view returns (address);

254:     function custodianAddress() external view returns (string memory);

259:     function nextUnprocessedEscrowIndex() external view returns (uint256);

265:     function getUnprocessedEscrows() external view returns (Escrow[] memory);

271:     function getEscrowsCount() external view returns (uint256);

278:     function getEscrowByIndex(uint256 _index) external view returns (Escrow memory);

285:     function getEscrowByPreimageHash(bytes32 _preimageHash) external view returns (Escrow memory);

290:     function nextUnusedPreimageHashIndex() external view returns (uint256);

296:     function getUnusedPreimageHashes() external view returns (bytes32[] memory);

302:     function getPreimageHashesCount() external view returns (uint256);

309:     function getPreimageHash(uint256 _index) external view returns (bytes32);

315:     function getCancelableTransferRequests() external view returns (TransferRequest[] memory);

321:     function getNonCancelableTransferRequests() external view returns (TransferRequest[] memory);

327:     function getEmergencyPauseSenders() external view returns (address[] memory);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/ICoreVaultManager.sol)

```solidity
File: ./contracts/userInterfaces/IFAsset.sol

15:     function assetName() external view returns (string memory);

20:     function assetSymbol() external view returns (string memory);

26:     function assetManager() external view returns (address);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IFAsset.sol)

```solidity
File: ./contracts/userInterfaces/IRedemptionTimeExtension.sol

5:     function setRedemptionPaymentExtensionSeconds(uint256 _value)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IRedemptionTimeExtension.sol)

```solidity
File: ./contracts/utils/library/MathUtils.sol

8:     function roundUp(uint256 x, uint256 rounding) internal pure returns (uint256) {

17:     function subOrZero(uint256 _a, uint256 _b) internal pure returns (uint256) {

24:     function positivePart(int256 _x) internal pure returns (uint256) {

31:     function mixedLTE(uint256 _a, int256 _b) internal pure returns (bool) {

38:     function mixedLTE(int256 _a, uint256 _b) internal pure returns (bool) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/utils/library/MathUtils.sol)

```solidity
File: ./contracts/utils/library/SafeMath64.sol

14:     function toUint64(int256 a) internal pure returns (uint64) {

20:     function toInt64(uint256 a) internal pure returns (int64) {

25:     function max64(uint64 a, uint64 b) internal pure returns (uint64) {

29:     function min64(uint64 a, uint64 b) internal pure returns (uint64) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/utils/library/SafeMath64.sol)

```solidity
File: ./contracts/utils/library/SafePct.sol

24:     function mulDiv(uint256 x, uint256 y, uint256 z) internal pure returns (uint256) {

49:     function mulDivRoundUp(uint256 x, uint256 y, uint256 z) internal pure returns (uint256) {

62:     function mulBips(uint256 x, uint256 y) internal pure returns (uint256) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/utils/library/SafePct.sol)

```solidity
File: ./contracts/utils/library/Transfers.sol

30:     function transferNAT(address payable _recipient, uint256 _amount)

50:     function depositWNat(IWNat _wNat, address _recipient, uint256 _amount)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/utils/library/Transfers.sol)

### <a name="NC-8"></a>[NC-8] Change int to int256
Throughout the code base, some variables are declared as `int`. To favor explicitness, consider changing all instances of `int` to `int256`

*Instances (5)*:
```solidity
File: ./contracts/assetManager/library/data/Agent.sol

16:         DESTROYING,         // agent announced destroy, cannot mint again

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/Agent.sol)

```solidity
File: ./contracts/assetManager/library/data/CollateralTypeInt.sol

7: library CollateralTypeInt {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/CollateralTypeInt.sol)

```solidity
File: ./contracts/assetManager/library/data/PaymentReference.sol

20:     uint256 internal constant SELF_MINT = 0x4642505266410012 << TYPE_SHIFT;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/PaymentReference.sol)

```solidity
File: ./contracts/fassetToken/library/CheckPointHistory.sol

24:     struct CheckPoint {

141:             CheckPoint storage lastCheckpoint = _self.checkpoints[historyCount - 1];

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/library/CheckPointHistory.sol)

### <a name="NC-9"></a>[NC-9] `mapping` definitions do not follow the Solidity Style Guide
See the [mappings](https://docs.soliditylang.org/en/latest/style-guide.html#mappings) section of the Solidity Style Guide

*Instances (4)*:
```solidity
File: ./contracts/assetManager/facets/SettingsManagementFacet.sol

42:         mapping (bytes4 => uint256) lastUpdate;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/SettingsManagementFacet.sol)

```solidity
File: ./contracts/assetManager/library/SettingsUpdater.sol

12:         mapping (bytes32 => uint256) lastUpdate;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/SettingsUpdater.sol)

```solidity
File: ./contracts/assetManager/library/data/UnderlyingAddressOwnership.sol

21:         mapping (bytes32 => Ownership) ownership;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/UnderlyingAddressOwnership.sol)

```solidity
File: ./contracts/ftso/implementation/FtsoV2PriceStore.sol

74:     mapping(bytes21 feedId => mapping (uint32 votingRoundId => bytes)) internal submittedTrustedPrices;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/ftso/implementation/FtsoV2PriceStore.sol)

### <a name="NC-10"></a>[NC-10] Use a `modifier` instead of a `require/if` statement for a special `msg.sender` actor
If a function is supposed to be access-controlled, a `modifier` should be used instead of a `require/if` statement for more readability.

*Instances (38)*:
```solidity
File: ./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistry.sol

34:         require(msg.sender == manager || msg.sender == governance(), OnlyGovernanceOrManager());

84:         require(isWhitelisted(msg.sender), AgentNotWhitelisted());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistry.sol)

```solidity
File: ./contracts/agentVault/implementation/AgentVault.sol

29:         require(isOwner(msg.sender), OnlyOwner());

34:         require(msg.sender == address(assetManager), OnlyAssetManager());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentVault/implementation/AgentVault.sol)

```solidity
File: ./contracts/assetManager/facets/AgentCollateralFacet.sol

141:         require(msg.sender == _agentVault || msg.sender == address(agent.collateralPool),

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentCollateralFacet.sol)

```solidity
File: ./contracts/assetManager/facets/AssetManagerBase.sol

38:         require(msg.sender == settings.assetManagerController, OnlyAssetManagerController());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AssetManagerBase.sol)

```solidity
File: ./contracts/assetManager/facets/CollateralReservationsFacet.sol

73:         require(agent.availableAgentsPos != 0 || agent.alwaysAllowedMinters.contains(msg.sender),

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/CollateralReservationsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/MintingFacet.sol

73:         require(msg.sender == crt.minter || msg.sender == crt.executor || Agents.isOwner(agent, msg.sender),

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/MintingFacet.sol)

```solidity
File: ./contracts/assetManager/library/Agents.sol

114:         require(isOwner(Agent.get(_agentVault), msg.sender), OnlyAgentVaultOwner());

122:         require(isOwner(_agent, msg.sender), OnlyAgentVaultOwner());

130:         require(msg.sender == address(_agent.collateralPool), OnlyCollateralPool());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Agents.sol)

```solidity
File: ./contracts/assetManager/library/Minting.sol

43:             if (msg.sender == _crt.executor) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Minting.sol)

```solidity
File: ./contracts/assetManager/library/Redemptions.sol

104:             if (msg.sender == _request.executor) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Redemptions.sol)

```solidity
File: ./contracts/assetManagerController/implementation/AssetManagerController.sol

647:         require(byGovernance || emergencyPauseSenders.contains(msg.sender),

657:         require(byGovernance || emergencyPauseSenders.contains(msg.sender),

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManagerController/implementation/AssetManagerController.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPool.sol

61:         require(msg.sender == address(assetManager), OnlyAssetManager());

66:         require(isAgentVaultOwner(msg.sender), OnlyAgent());

194:         require(_tokenShare <= token.balanceOf(msg.sender), TokenBalanceTooLow());

278:         require(_tokenShare <= token.balanceOf(msg.sender), TokenBalanceTooLow());

292:         require(fAsset.allowance(msg.sender, address(this)) >= requiredFAssets, FAssetAllowanceTooSmall());

381:         require(_fAssets.toInt256() <= _fAssetFeeDebtOf[msg.sender], PaymentLargerThanFeeDebt());

382:         require(fAsset.allowance(msg.sender, address(this)) >= _fAssets, FAssetAllowanceTooSmall());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPool.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPoolToken.sol

46:         require(msg.sender == collateralPool, OnlyCollateralPool());

203:         if (msg.sender != collateralPool) {

278:         require(msg.sender == address(assetManager), OnlyAssetManager());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPoolToken.sol)

```solidity
File: ./contracts/coreVaultManager/implementation/CoreVaultManager.sol

279:         require(triggeringAccounts.contains(msg.sender), NotAuthorized());

630:         require(msg.sender == governance() || emergencyPauseSenders.contains(msg.sender), NotAuthorized());

888:         require(msg.sender == assetManager, OnlyAssetManager());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/coreVaultManager/implementation/CoreVaultManager.sol)

```solidity
File: ./contracts/fassetToken/implementation/CheckPointable.sol

53:         require(msg.sender == cleanerContract, OnlyCleanerContract());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/implementation/CheckPointable.sol)

```solidity
File: ./contracts/fassetToken/implementation/FAsset.sol

67:         require(msg.sender == assetManager, OnlyAssetManager());

111:         require (msg.sender == _deployer, OnlyDeployer());

169:         require(msg.sender == cleanupBlockNumberManager, OnlyCleanupBlockManager());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/implementation/FAsset.sol)

```solidity
File: ./contracts/flareSmartContracts/implementation/AddressUpdatable.sol

17:         require (msg.sender == getAddressUpdater(), OnlyAddressUpdater());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/flareSmartContracts/implementation/AddressUpdatable.sol)

```solidity
File: ./contracts/ftso/implementation/FtsoV2PriceStore.sol

176:         require(trustedProvidersMap[msg.sender], OnlyTrustedProvider());

184:         require(lastVotingEpochIdByProvider[msg.sender] < previousVotingEpochId, AlreadySubmitted());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/ftso/implementation/FtsoV2PriceStore.sol)

```solidity
File: ./contracts/governance/implementation/GovernedBase.sol

61:         require(isExecutor(msg.sender), OnlyExecutor());

150:             assert(msg.sender == address(this));

178:         require(msg.sender == governance(), OnlyGovernance());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/governance/implementation/GovernedBase.sol)

### <a name="NC-11"></a>[NC-11] Consider using named mappings
Consider moving to solidity version 0.8.18 or later, and using [named mappings](https://ethereum.stackexchange.com/questions/51629/how-to-name-the-arguments-in-mapping/145555#145555) to make it easier to understand the purpose of each mapping

*Instances (26)*:
```solidity
File: ./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistry.sol

23:     mapping(address => bool) private whitelist;

25:     mapping(address => address) private workToMgmtAddress;

26:     mapping(address => address) private mgmtToWorkAddress;

28:     mapping(address => string) private agentName;

29:     mapping(address => string) private agentDescription;

30:     mapping(address => string) private agentIconUrl;

31:     mapping(address => string) private agentTouUrl;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistry.sol)

```solidity
File: ./contracts/agentVault/implementation/AgentVault.sol

23:     mapping(IERC20 => uint256) private __tokenUseFlags; // only storage placeholder

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentVault/implementation/AgentVault.sol)

```solidity
File: ./contracts/assetManager/library/data/Agent.sol

158:         mapping(bytes32 => SettingUpdate) settingUpdates;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/Agent.sol)

```solidity
File: ./contracts/assetManager/library/data/AssetManagerState.sol

19:         mapping(bytes32 => uint256) collateralTokenIndex;

22:         mapping(string => bool) reservedPoolTokenSuffixes;

37:         mapping(uint256 => CollateralReservation.Data) crts;

43:         mapping(uint256 => Redemption.Request) redemptionRequests;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/AssetManagerState.sol)

```solidity
File: ./contracts/assetManager/library/data/PaymentConfirmations.sol

14:         mapping(bytes32 => bytes32) verifiedPayments;

16:         mapping(uint256 => bytes32) __verifiedPaymentsForDay; // only storage placeholder

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/PaymentConfirmations.sol)

```solidity
File: ./contracts/assetManager/library/data/RedemptionQueue.sol

21:         mapping(uint64 => Ticket) tickets;      // mapping redemption_id=>ticket

22:         mapping(address => AgentQueue) agents;  // mapping address=>dl-list

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/RedemptionQueue.sol)

```solidity
File: ./contracts/assetManagerController/implementation/AssetManagerController.sol

49:     mapping(address => uint256) private assetManagerIndex;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManagerController/implementation/AssetManagerController.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPool.sol

55:     mapping(address => int256) private _fAssetFeeDebtOf;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPool.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPoolToken.sol

31:         mapping(uint256 => Timelock) data;

41:     mapping(address => TimelockQueue) private timelocksByAccount;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPoolToken.sol)

```solidity
File: ./contracts/diamond/library/LibDiamond.sol

41:         mapping(bytes4 => FacetAddressAndSelectorPosition) facetAddressAndSelectorPosition;

43:         mapping(bytes4 => bool) supportedInterfaces;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/diamond/library/LibDiamond.sol)

```solidity
File: ./contracts/fassetToken/library/CheckPointHistory.sol

33:         mapping(uint256 => CheckPoint) checkpoints;

49:         mapping(uint256 => CheckPoint) storage _checkpoints,

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/library/CheckPointHistory.sol)

```solidity
File: ./contracts/fassetToken/library/CheckPointsByAddress.sol

17:         mapping(address => CheckPointHistory.CheckPointHistoryState) historyByAddress;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/library/CheckPointsByAddress.sol)

### <a name="NC-12"></a>[NC-12] `address`s shouldn't be hard-coded
It is often better to declare `address`es as `immutable`, and assign them via constructor arguments. This allows the code to remain the same across deployments on different networks, and avoids recompilation when addresses need to change.

*Instances (1)*:
```solidity
File: ./contracts/governance/implementation/GovernedProxyImplementation.sol

15:     address private constant EMPTY_ADDRESS = 0x0000000000000000000000000000000000001111;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/governance/implementation/GovernedProxyImplementation.sol)

### <a name="NC-13"></a>[NC-13] Numeric values having to do with time should use time units for readability
There are [units](https://docs.soliditylang.org/en/latest/units-and-global-variables.html#time-units) for seconds, minutes, hours, days, and weeks, and since they're defined, they should be used

*Instances (1)*:
```solidity
File: ./contracts/coreVaultManager/implementation/CoreVaultManager.sol

866:         uint256 escrowEndTimestamp = 0;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/coreVaultManager/implementation/CoreVaultManager.sol)

### <a name="NC-14"></a>[NC-14] Take advantage of Custom Error's return value property
An important feature of Custom Error is that values such as address, tokenID, msg.value can be written inside the () sign, this kind of approach provides a serious advantage in debugging and examining the revert details of dapps such as tenderly.

*Instances (3)*:
```solidity
File: ./contracts/assetManager/facets/EmergencyPauseFacet.sol

29:                 revert PausedByGovernance();

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/EmergencyPauseFacet.sol)

```solidity
File: ./contracts/assetManager/facets/EmergencyPauseTransfersFacet.sol

29:                 revert PausedByGovernance();

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/EmergencyPauseTransfersFacet.sol)

```solidity
File: ./contracts/diamond/implementation/Diamond.sol

44:                     revert(0, returndatasize())

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/diamond/implementation/Diamond.sol)

### <a name="NC-15"></a>[NC-15] Deprecated library used for Solidity `>= 0.8` : SafeMath

*Instances (9)*:
```solidity
File: ./contracts/assetManager/facets/CoreVaultClientFacet.sol

23: import {SafeMath64} from "../../utils/library/SafeMath64.sol";

213:         uint64 remintedAMG = SafeMath64.min64(agent.returnFromCoreVaultReservedAMG, receivedAmountAMG);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/CoreVaultClientFacet.sol)

```solidity
File: ./contracts/assetManager/library/Redemptions.sol

4: import {SafeMath64} from "../../utils/library/SafeMath64.sol";

43:             uint64 ticketRedeemAMG = SafeMath64.min64(_amountAMG - _closedAMG, maxTicketRedeemAMG);

49:         uint64 closeDustAMG = SafeMath64.min64(_amountAMG - _closedAMG, _agent.dustAMG);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Redemptions.sol)

```solidity
File: ./contracts/assetManager/library/data/RedemptionTimeExtension.sol

5: import {SafeMath64} from "../../../utils/library/SafeMath64.sol";

10:     using SafeMath64 for uint64;

37:         agentData.extendedTimestamp = SafeMath64.max64(accumulatedTimestamp, timestamp);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/RedemptionTimeExtension.sol)

```solidity
File: ./contracts/utils/library/SafeMath64.sol

5: library SafeMath64 {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/utils/library/SafeMath64.sol)

### <a name="NC-16"></a>[NC-16] Avoid the use of sensitive terms
Use [alternative variants](https://www.zdnet.com/article/mysql-drops-master-slave-and-blacklist-whitelist-terminology/), e.g. allowlist/denylist instead of whitelist/blacklist

*Instances (32)*:
```solidity
File: ./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistry.sol

23:     mapping(address => bool) private whitelist;

43:         _removeAddressFromWhitelist(_address);

61:     function whitelistAndDescribeAgent(

71:         _addAddressToWhitelist(_managementAddress);

84:         require(isWhitelisted(msg.sender), AgentNotWhitelisted());

216:     function isWhitelisted(address _address) public view override returns (bool) {

217:         return whitelist[_address];

220:     function _addAddressToWhitelist(address _address) internal {

222:         if (whitelist[_address]) return;

223:         whitelist[_address] = true;

224:         emit Whitelisted(_address);

227:     function _removeAddressFromWhitelist(address _address) internal {

228:         if (!whitelist[_address]) return;

229:         delete whitelist[_address];

230:         emit WhitelistingRevoked(_address);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistry.sol)

```solidity
File: ./contracts/assetManager/facets/AgentVaultManagementFacet.sol

71:         Agents.requireWhitelisted(ownerManagementAddress);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentVaultManagementFacet.sol)

```solidity
File: ./contracts/assetManager/facets/AssetManagerBase.sol

13:     error NotWhitelisted();

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AssetManagerBase.sol)

```solidity
File: ./contracts/assetManager/facets/CollateralReservationsFacet.sol

69:         Agents.requireWhitelistedAgentVaultOwner(agent);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/CollateralReservationsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/MintingFacet.sol

124:         Agents.requireWhitelistedAgentVaultOwner(agent);

176:         Agents.requireWhitelistedAgentVaultOwner(agent);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/MintingFacet.sol)

```solidity
File: ./contracts/assetManager/library/Agents.sol

24:     error AgentNotWhitelisted();

92:     function requireWhitelisted(

97:         require(Globals.getAgentOwnerRegistry().isWhitelisted(_ownerManagementAddress),

98:             AgentNotWhitelisted());

101:     function requireWhitelistedAgentVaultOwner(

106:         requireWhitelisted(_agent.ownerManagementAddress);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Agents.sol)

```solidity
File: ./contracts/assetManager/library/SettingsInitializer.sol

93:         require(_settings.__whitelist == address(0), MustBeZero());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/SettingsInitializer.sol)

```solidity
File: ./contracts/userInterfaces/IAgentOwnerRegistry.sol

10:     event Whitelisted(address value);

11:     event WhitelistingRevoked(address value);

28:     error AgentNotWhitelisted();

36:     function isWhitelisted(address _address) external view returns (bool);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAgentOwnerRegistry.sol)

```solidity
File: ./contracts/userInterfaces/data/AssetManagerSettings.sol

42:         address __whitelist; // only storage placeholder

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/AssetManagerSettings.sol)

### <a name="NC-17"></a>[NC-17] Some require descriptions are not clear
1. It does not comply with the general require error description model of the project (Either all of them should be debugged in this way, or all of them should be explained with a string not exceeding 32 bytes.)
2. For debug dapps like Tenderly, these debug messages are important, this allows the user to see the reasons for revert practically.

*Instances (1)*:
```solidity
File: ./contracts/assetManager/facets/AgentVaultManagementFacet.sol

297:             require((ch >= "A" && ch <= "Z") || (ch >= "0" && ch <= "9") || (i > 0 && i < len - 1 && ch == "-"),

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentVaultManagementFacet.sol)

### <a name="NC-18"></a>[NC-18] Use Underscores for Number Literals (add an underscore every 3 digits)

*Instances (10)*:
```solidity
File: ./contracts/assetManager/facets/CollateralReservationsFacet.sol

193:         uint64 blockshift = (uint256(timeshift) * 1000 / settings.averageBlockTimeMS).toUint64();

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/CollateralReservationsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/RedemptionTimeExtensionFacet.sol

49:         require(_value <= currentValue * 4 + settings.averageBlockTimeMS / 1000, IncreaseTooBig());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/RedemptionTimeExtensionFacet.sol)

```solidity
File: ./contracts/assetManager/facets/SettingsManagementFacet.sol

315:         require(_value <= uint256(settings.redemptionDefaultFactorVaultCollateralBIPS).mulBips(12000) + 1000,

601:         require(_value <= settings.emergencyPauseDurationResetAfterSeconds * 4 + 3600, IncreaseTooBig());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/SettingsManagementFacet.sol)

```solidity
File: ./contracts/assetManager/library/AgentUpdates.sol

112:         require(_buyFAssetByAgentFactorBIPS >= 9000, ValueTooLow());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/AgentUpdates.sol)

```solidity
File: ./contracts/assetManager/library/RedemptionRequests.sol

137:         uint64 blockshift = (uint256(timeshift) * 1000 / settings.averageBlockTimeMS).toUint64();

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/RedemptionRequests.sol)

```solidity
File: ./contracts/assetManager/library/SettingsValidators.sol

27:         require(_underlyingBlocks * _averageBlockTimeMS / 1000 <= MAXIMUM_PROOF_WINDOW, ValueTooHigh());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/SettingsValidators.sol)

```solidity
File: ./contracts/assetManager/library/UnderlyingBlockUpdater.sol

45:             _numberOfConfirmations * Globals.getSettings().averageBlockTimeMS / 1000;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/UnderlyingBlockUpdater.sol)

```solidity
File: ./contracts/assetManager/library/data/PaymentReference.sol

9:     uint256 private constant ID_RANDOMIZATION = 1000;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/PaymentReference.sol)

```solidity
File: ./contracts/fassetToken/implementation/FAsset.sol

75:         _version = 1000;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/implementation/FAsset.sol)

### <a name="NC-19"></a>[NC-19] Constants should be defined rather than using magic numbers

*Instances (2)*:
```solidity
File: ./contracts/assetManager/facets/SettingsManagementFacet.sol

315:         require(_value <= uint256(settings.redemptionDefaultFactorVaultCollateralBIPS).mulBips(12000) + 1000,

317:         require(_value >= uint256(settings.redemptionDefaultFactorVaultCollateralBIPS).mulBips(8333),

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/SettingsManagementFacet.sol)

### <a name="NC-20"></a>[NC-20] Variables need not be initialized to zero
The default value for variables is zero, so initializing them to zero is superfluous.

*Instances (50)*:
```solidity
File: ./contracts/assetManager/facets/AgentVaultManagementFacet.sol

225:         for (uint256 i = 0; i < _agents.length; i++) {

294:         for (uint256 i = 0; i < len; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentVaultManagementFacet.sol)

```solidity
File: ./contracts/assetManager/facets/ChallengesFacet.sol

155:         for (uint256 i = 0; i < _payments.length; i++) {

159:             for (uint256 j = 0; j < i; j++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/ChallengesFacet.sol)

```solidity
File: ./contracts/assetManager/facets/RedemptionRequestsFacet.sol

73:         uint256 redeemedLots = 0;

74:         for (uint256 i = 0; i < maxRedeemedTickets && redeemedLots < _lots; i++) {

84:         for (uint256 i = 0; i < redemptionList.length; i++) {

178:         for (uint256 i = 0; ticketId != 0 && i < maxRedeemedTickets; i++) {

311:             uint256 index = 0;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/RedemptionRequestsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/SettingsManagementFacet.sol

568:         for (uint256 i = 0; i < _liquidationFactors.length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/SettingsManagementFacet.sol)

```solidity
File: ./contracts/assetManager/library/CollateralTypes.sol

80:         for (uint256 i = 0; i < length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/CollateralTypes.sol)

```solidity
File: ./contracts/assetManager/library/RedemptionQueueInfo.sol

46:         uint256 count = 0;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/RedemptionQueueInfo.sol)

```solidity
File: ./contracts/assetManager/library/Redemptions.sol

34:         for (uint256 i = 0; i < maxRedeemedTickets && _closedAMG < _amountAMG; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Redemptions.sol)

```solidity
File: ./contracts/assetManager/library/SettingsValidators.sol

38:         for (uint256 i = 0; i < liquidationFactors.length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/SettingsValidators.sol)

```solidity
File: ./contracts/assetManagerController/implementation/AssetManagerController.sol

109:         assetManagerIndex[address(_assetManager)] = 0;

125:         for (uint256 i = 0; i < length; i++) {

715:         for (uint256 i = 0; i < _assetManagers.length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManagerController/implementation/AssetManagerController.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPoolToken.sol

233:         for (uint256 count = 0; count < _maxTimelockedEntries; count++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPoolToken.sol)

```solidity
File: ./contracts/coreVaultManager/implementation/CoreVaultManager.sol

193:             for (uint256 i = 0; i < cancelableTransferRequests.length; i++) {

201:             uint256 index = 0;

244:         uint256 index = 0;

287:         uint256 index = 0;

410:         for (uint256 i = 0; i < _allowedDestinationAddresses.length; i++) {

432:         for (uint256 i = 0; i < _allowedDestinationAddresses.length; i++) {

460:         for (uint256 i = 0; i < _triggeringAccounts.length; i++) {

478:         for (uint256 i = 0; i < _triggeringAccounts.length; i++) {

538:         for (uint256 i = 0; i < _preimageHashes.length; i++) {

578:         for (uint256 i = 0; i < _preimageHashes.length; i++) {

603:         for (uint256 i = 0; i < _addresses.length; i++) {

619:         for (uint256 i = 0; i < _addresses.length; i++) {

699:         for (uint256 i = 0; i < length; i++) {

732:         for (uint256 i = 0; i < length; i++) {

757:         for (uint256 i = 0; i < cancelableTransferRequests.length; i++) {

767:         for (uint256 i = 0; i < nonCancelableTransferRequests.length; i++) {

866:         uint256 escrowEndTimestamp = 0;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/coreVaultManager/implementation/CoreVaultManager.sol)

```solidity
File: ./contracts/flareSmartContracts/implementation/AddressUpdatable.sol

71:         address a = address(0);

72:         for (uint256 i = 0; i < _nameHashes.length; i++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/flareSmartContracts/implementation/AddressUpdatable.sol)

```solidity
File: ./contracts/ftso/implementation/FtsoV2PriceStore.sol

124:         uint32 votingRoundId = 0;

126:         for (uint256 i = 0; i < _proofs.length; i++) {

188:         for (uint256 i = 0; i < _feeds.length; i++) {

218:         for (uint256 i = 0; i < _feedIds.length; i++) {

251:         for (uint256 i = 0; i < trustedProviders.length; i++) {

256:         for (uint256 i = 0; i < _trustedProviders.length; i++) {

322:         for (uint256 i = 0; i < _feedIds.length; i++) {

332:         for (uint256 i = 0; i < feedIds.length; i++) {

406:         for (uint256 i = 0; i < length; i++) {

408:             for (uint256 j = 0; j < 4; j++) {

428:         uint256 spread = 0;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/ftso/implementation/FtsoV2PriceStore.sol)

```solidity
File: ./contracts/utils/library/MerkleTree.sol

62:         uint256 stackTop = 0;

74:         for (uint256 initialLevel = 0; initialLevel < 2; initialLevel++) {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/utils/library/MerkleTree.sol)


## Low Issues


| |Issue|Instances|
|-|:-|:-:|
| [L-1](#L-1) | `decimals()` should be of type `uint8` | 8 |
| [L-2](#L-2) | Division by zero not prevented | 17 |
| [L-3](#L-3) | Initializers could be front-run | 17 |
| [L-4](#L-4) | Signature use at deadlines should be allowed | 17 |
| [L-5](#L-5) | Loss of precision | 11 |
| [L-6](#L-6) | Unsafe ERC20 operation(s) | 5 |
| [L-7](#L-7) | Unspecific compiler version pragma | 22 |
| [L-8](#L-8) | Upgradeable contract is missing a `__gap[50]` storage variable to allow for new storage variables in later versions | 19 |
| [L-9](#L-9) | Upgradeable contract not initialized | 89 |
### <a name="L-1"></a>[L-1] `decimals()` should be of type `uint8`

*Instances (8)*:
```solidity
File: ./contracts/assetManager/library/Conversion.sol

175:         uint256 _tokenDecimals,

177:         uint256 _tokenFtsoDecimals,

179:         uint256 _assetFtsoDecimals

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Conversion.sol)

```solidity
File: ./contracts/ftso/implementation/FtsoV2PriceStore.sol

266:         returns (uint256 _price, uint256 _timestamp, uint256 _priceDecimals)

287:         returns (uint256 _price, uint256 _timestamp, uint256 _priceDecimals)

300:         returns (uint256 _price, uint256 _timestamp, uint256 _priceDecimals, uint8 _numberOfSubmits)

382:         returns (uint256 _price, uint256 _timestamp, uint256 _priceDecimals)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/ftso/implementation/FtsoV2PriceStore.sol)

```solidity
File: ./contracts/userInterfaces/IAssetManagerEvents.sol

479:         uint256 decimals,

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAssetManagerEvents.sol)

### <a name="L-2"></a>[L-2] Division by zero not prevented
The divisions below take an input parameter which does not have any zero-value checks, which may lead to the functions reverting when zero is passed.

*Instances (17)*:
```solidity
File: ./contracts/assetManager/facets/CollateralReservationsFacet.sol

101:             cr.executorFeeNatGWei = ((msg.value - reservationFee) / Conversion.GWEI).toUint64();

193:         uint64 blockshift = (uint256(timeshift) * 1000 / settings.averageBlockTimeMS).toUint64();

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/CollateralReservationsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/RedemptionRequestsFacet.sol

83:         uint256 executorFeeNatGWei = msg.value / Conversion.GWEI;

86:             uint256 currentExecutorFeeNatGWei = executorFeeNatGWei / (redemptionList.length - i);

126:             _executor, (msg.value / Conversion.GWEI).toUint64(), 0, false);

306:         uint256 maxRedeemLots = (ticket.valueAMG + agent.dustAMG) / settings.lotSizeAMG;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/RedemptionRequestsFacet.sol)

```solidity
File: ./contracts/assetManager/library/AgentCollateral.sol

137:         return lotWei != 0 ? collateralWei / lotWei : 0;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/AgentCollateral.sol)

```solidity
File: ./contracts/assetManager/library/Conversion.sol

75:         return SafeCast.toUint64(_valueUBA / settings.assetMintingGranularityUBA);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Conversion.sol)

```solidity
File: ./contracts/assetManager/library/CoreVaultClient.sol

124:         return Conversion.convertUBAToAmg(totalAmountUBA) / settings.lotSizeAMG;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/CoreVaultClient.sol)

```solidity
File: ./contracts/assetManager/library/LiquidationPaymentStrategy.sol

66:         uint256 step = (block.timestamp - liquidationStart) / settings.liquidationStepSeconds;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/LiquidationPaymentStrategy.sol)

```solidity
File: ./contracts/assetManager/library/RedemptionRequests.sol

137:         uint64 blockshift = (uint256(timeshift) * 1000 / settings.averageBlockTimeMS).toUint64();

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/RedemptionRequests.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPool.sol

460:                 assetPrice.div * (totalCollateral - _natShare) * SafePct.MAX_BIPS / (assetPrice.mul * exitCR));

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPool.sol)

```solidity
File: ./contracts/ftso/implementation/FtsoV2PriceStore.sol

367:         return uint32((block.timestamp - firstVotingRoundStartTs) / votingEpochDurationSeconds) - 1;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/ftso/implementation/FtsoV2PriceStore.sol)

```solidity
File: ./contracts/utils/library/SafePct.sol

30:             if (xy / x == y) { // no overflow happened (works in unchecked)

36:         uint256 a = x / z;

40:         uint256 c = y / z;

43:         return (a * c * z) + (a * d) + (b * c) + (b * d / z);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/utils/library/SafePct.sol)

### <a name="L-3"></a>[L-3] Initializers could be front-run
Initializers could be front-run, allowing an attacker to either set their own values, take ownership of the contract, and in the best case forcing a re-deployment

*Instances (17)*:
```solidity
File: ./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistry.sol

38:     function initialize(IGovernanceSettings _governanceSettings, address _initialGovernance) external {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistry.sol)

```solidity
File: ./contracts/agentVault/implementation/AgentVault.sol

46:         initialize(_assetManager);

49:     function initialize(IIAssetManager _assetManager) public {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentVault/implementation/AgentVault.sol)

```solidity
File: ./contracts/agentVault/implementation/AgentVaultFactory.sol

26:         agentVault.initialize(_assetManager);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentVault/implementation/AgentVaultFactory.sol)

```solidity
File: ./contracts/assetManager/facets/AssetManagerInit.sol

25:     function init(

36:         CollateralTypes.initialize(_initialCollateralTypes);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AssetManagerInit.sol)

```solidity
File: ./contracts/assetManager/library/CollateralTypes.sol

27:     function initialize(

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/CollateralTypes.sol)

```solidity
File: ./contracts/assetManagerController/implementation/AssetManagerController.sol

64:     function initialize(

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManagerController/implementation/AssetManagerController.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPool.sol

78:         initialize(_agentVault, _assetManager, _fAsset, _exitCollateralRatioBIPS);

81:     function initialize(

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPool.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPoolFactory.sol

33:         pool.initialize(_agentVault, address(_assetManager), fAsset,

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPoolFactory.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPoolToken.sol

59:         initialize(_collateralPool, _tokenName, _tokenSymbol);

62:     function initialize(

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPoolToken.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPoolTokenFactory.sol

29:         poolToken.initialize(address(_pool), tokenName, tokenSymbol);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPoolTokenFactory.sol)

```solidity
File: ./contracts/coreVaultManager/implementation/CoreVaultManager.sol

120:     function initialize(

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/coreVaultManager/implementation/CoreVaultManager.sol)

```solidity
File: ./contracts/fassetToken/implementation/FAsset.sol

78:     function initialize(

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/implementation/FAsset.sol)

```solidity
File: ./contracts/ftso/implementation/FtsoV2PriceStore.sol

98:     function initialize(

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/ftso/implementation/FtsoV2PriceStore.sol)

### <a name="L-4"></a>[L-4] Signature use at deadlines should be allowed
According to [EIP-2612](https://github.com/ethereum/EIPs/blob/71dc97318013bf2ac572ab63fab530ac9ef419ca/EIPS/eip-2612.md?plain=1#L58), signatures used on exactly the deadline timestamp are supposed to be allowed. While the signature may or may not be used for the exact EIP-2612 use case (transfer approvals), for consistency's sake, all deadlines should follow this semantic. If the timestamp is an expiration rather than a deadline, consider whether it makes more sense to include the expiration timestamp as a valid timestamp, as is done for deadlines.

*Instances (17)*:
```solidity
File: ./contracts/assetManager/facets/AgentSettingsFacet.sol

70:         require(update.validAt <= block.timestamp, UpdateNotValidYet());

72:         require(update.validAt + settings.agentTimelockedOperationWindowSeconds >= block.timestamp,

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AgentSettingsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/AssetManagerBase.sol

47:         require(state.emergencyPausedUntil <= block.timestamp, EmergencyPauseActive());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AssetManagerBase.sol)

```solidity
File: ./contracts/assetManager/facets/CollateralTypesFacet.sol

82:         require(token.validUntil == 0 || token.validUntil > block.timestamp, TokenNotValid());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/CollateralTypesFacet.sol)

```solidity
File: ./contracts/assetManager/facets/EmergencyPauseFacet.sol

32:             if (state.emergencyPausedUntil + settings.emergencyPauseDurationResetAfterSeconds <= block.timestamp) {

84:         return state.emergencyPausedUntil > block.timestamp;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/EmergencyPauseFacet.sol)

```solidity
File: ./contracts/assetManager/facets/EmergencyPauseTransfersFacet.sol

33:             if (resetTs <= block.timestamp) {

86:         return state.transfersEmergencyPausedUntil > block.timestamp;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/EmergencyPauseTransfersFacet.sol)

```solidity
File: ./contracts/assetManager/library/CollateralTypes.sol

127:         return _token.validUntil == 0 || _token.validUntil > block.timestamp;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/CollateralTypes.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPoolToken.sol

179:             if (timelock.endTime > block.timestamp) {

234:             if (start >= timelocks.end || timelocks.data[start].endTime > block.timestamp) {

240:         return start >= timelocks.end || timelocks.data[start].endTime > block.timestamp;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPoolToken.sol)

```solidity
File: ./contracts/coreVaultManager/implementation/CoreVaultManager.sol

826:             (escrows[index].expiryTs <= block.timestamp || escrows[index].finished))

845:             (escrows[index].expiryTs > block.timestamp && !escrows[index].finished);

878:         if (escrowEndTimestamp <= block.timestamp + 12 hours) { // less than 12 hours from now, move to the next day

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/coreVaultManager/implementation/CoreVaultManager.sol)

```solidity
File: ./contracts/ftso/implementation/FtsoV2PriceStore.sol

108:         require(_firstVotingRoundStartTs + _votingEpochDurationSeconds <= block.timestamp, InvalidStartTime());

132:                 require(_getEndTimestamp(votingRoundId) + submitTrustedPricesWindowSeconds <= block.timestamp,

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/ftso/implementation/FtsoV2PriceStore.sol)

### <a name="L-5"></a>[L-5] Loss of precision
Division by large numbers may result in the result being zero, due to solidity not supporting fractions. Consider requiring a minimum amount for the numerator to ensure that it is always larger than the denominator

*Instances (11)*:
```solidity
File: ./contracts/assetManager/facets/CollateralReservationsFacet.sol

101:             cr.executorFeeNatGWei = ((msg.value - reservationFee) / Conversion.GWEI).toUint64();

193:         uint64 blockshift = (uint256(timeshift) * 1000 / settings.averageBlockTimeMS).toUint64();

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/CollateralReservationsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/RedemptionRequestsFacet.sol

83:         uint256 executorFeeNatGWei = msg.value / Conversion.GWEI;

126:             _executor, (msg.value / Conversion.GWEI).toUint64(), 0, false);

306:         uint256 maxRedeemLots = (ticket.valueAMG + agent.dustAMG) / settings.lotSizeAMG;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/RedemptionRequestsFacet.sol)

```solidity
File: ./contracts/assetManager/library/Conversion.sol

75:         return SafeCast.toUint64(_valueUBA / settings.assetMintingGranularityUBA);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Conversion.sol)

```solidity
File: ./contracts/assetManager/library/CoreVaultClient.sol

124:         return Conversion.convertUBAToAmg(totalAmountUBA) / settings.lotSizeAMG;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/CoreVaultClient.sol)

```solidity
File: ./contracts/assetManager/library/RedemptionRequests.sol

137:         uint64 blockshift = (uint256(timeshift) * 1000 / settings.averageBlockTimeMS).toUint64();

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/RedemptionRequests.sol)

```solidity
File: ./contracts/assetManager/library/SettingsValidators.sol

27:         require(_underlyingBlocks * _averageBlockTimeMS / 1000 <= MAXIMUM_PROOF_WINDOW, ValueTooHigh());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/SettingsValidators.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPool.sol

460:                 assetPrice.div * (totalCollateral - _natShare) * SafePct.MAX_BIPS / (assetPrice.mul * exitCR));

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPool.sol)

```solidity
File: ./contracts/ftso/implementation/FtsoV2PriceStore.sol

441:         _priceOk = spread <= maxSpreadBIPS * _medianPrice / MAX_BIPS; // no overflow

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/ftso/implementation/FtsoV2PriceStore.sol)

### <a name="L-6"></a>[L-6] Unsafe ERC20 operation(s)

*Instances (5)*:
```solidity
File: ./contracts/assetManager/facets/MintingDefaultsFacet.sol

110:         Globals.getBurnAddress().transfer(crt.reservationFeeNatWei + crt.executorFeeNatGWei * Conversion.GWEI);

145:         Globals.getBurnAddress().transfer(_burnedNatWei);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/MintingDefaultsFacet.sol)

```solidity
File: ./contracts/assetManager/library/Minting.sol

46:                 Globals.getBurnAddress().transfer(executorFeeNatWei);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Minting.sol)

```solidity
File: ./contracts/assetManager/library/Redemptions.sol

107:                 Globals.getBurnAddress().transfer(executorFeeNatWei);

121:             Globals.getBurnAddress().transfer(executorFeeNatWei);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/Redemptions.sol)

### <a name="L-7"></a>[L-7] Unspecific compiler version pragma

*Instances (22)*:
```solidity
File: ./contracts/userInterfaces/IAgentAlwaysAllowedMinters.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAgentAlwaysAllowedMinters.sol)

```solidity
File: ./contracts/userInterfaces/IAgentOwnerRegistry.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAgentOwnerRegistry.sol)

```solidity
File: ./contracts/userInterfaces/IAgentPing.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAgentPing.sol)

```solidity
File: ./contracts/userInterfaces/IAgentVault.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAgentVault.sol)

```solidity
File: ./contracts/userInterfaces/IAssetManager.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAssetManager.sol)

```solidity
File: ./contracts/userInterfaces/IAssetManagerController.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAssetManagerController.sol)

```solidity
File: ./contracts/userInterfaces/IAssetManagerEvents.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAssetManagerEvents.sol)

```solidity
File: ./contracts/userInterfaces/ICollateralPool.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/ICollateralPool.sol)

```solidity
File: ./contracts/userInterfaces/ICollateralPoolToken.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/ICollateralPoolToken.sol)

```solidity
File: ./contracts/userInterfaces/ICoreVaultClient.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/ICoreVaultClient.sol)

```solidity
File: ./contracts/userInterfaces/ICoreVaultClientSettings.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/ICoreVaultClientSettings.sol)

```solidity
File: ./contracts/userInterfaces/ICoreVaultManager.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/ICoreVaultManager.sol)

```solidity
File: ./contracts/userInterfaces/IFAsset.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IFAsset.sol)

```solidity
File: ./contracts/userInterfaces/IRedemptionTimeExtension.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IRedemptionTimeExtension.sol)

```solidity
File: ./contracts/userInterfaces/data/AgentInfo.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/AgentInfo.sol)

```solidity
File: ./contracts/userInterfaces/data/AgentSettings.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/AgentSettings.sol)

```solidity
File: ./contracts/userInterfaces/data/AssetManagerSettings.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/AssetManagerSettings.sol)

```solidity
File: ./contracts/userInterfaces/data/AvailableAgentInfo.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/AvailableAgentInfo.sol)

```solidity
File: ./contracts/userInterfaces/data/CollateralReservationInfo.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/CollateralReservationInfo.sol)

```solidity
File: ./contracts/userInterfaces/data/CollateralType.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/CollateralType.sol)

```solidity
File: ./contracts/userInterfaces/data/RedemptionRequestInfo.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/RedemptionRequestInfo.sol)

```solidity
File: ./contracts/userInterfaces/data/RedemptionTicketInfo.sol

2: pragma solidity >=0.7.6 <0.9;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/data/RedemptionTicketInfo.sol)

### <a name="L-8"></a>[L-8] Upgradeable contract is missing a `__gap[50]` storage variable to allow for new storage variables in later versions
See [this](https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps) link for a description of this storage variable. While some contracts may not currently be sub-classed, adding the variable now protects against forgetting to add it in the future.

*Instances (19)*:
```solidity
File: ./contracts/agentVault/implementation/AgentVault.sol

7: import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

15: contract AgentVault is ReentrancyGuard, UUPSUpgradeable, IIAgentVault, IERC165 {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentVault/implementation/AgentVault.sol)

```solidity
File: ./contracts/assetManagerController/implementation/AssetManagerController.sol

6: import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

17: import {IUUPSUpgradeable} from "../../utils/interfaces/IUUPSUpgradeable.sol";

30:     UUPSUpgradeable,

148:         public override (IUUPSUpgradeable, UUPSUpgradeable)

159:         public payable override (IUUPSUpgradeable, UUPSUpgradeable)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManagerController/implementation/AssetManagerController.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPool.sol

6: import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

25: contract CollateralPool is IICollateralPool, ReentrancyGuard, UUPSUpgradeable, IERC165 {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPool.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPoolToken.sol

8: import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

16: contract CollateralPoolToken is IICollateralPoolToken, ERC20, UUPSUpgradeable {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPoolToken.sol)

```solidity
File: ./contracts/fassetToken/implementation/FAsset.sol

10: import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

20: contract FAsset is IIFAsset, IERC165, ERC20, CheckPointable, UUPSUpgradeable, ERC20Permit {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/implementation/FAsset.sol)

```solidity
File: ./contracts/governance/implementation/GovernedUUPSProxyImplementation.sol

4: import { UUPSUpgradeable } from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

6: import { IUUPSUpgradeable } from "../../utils/interfaces/IUUPSUpgradeable.sol";

12:     UUPSUpgradeable,

14:     IUUPSUpgradeable

24:         public override (IUUPSUpgradeable, UUPSUpgradeable)

35:         public payable override (IUUPSUpgradeable, UUPSUpgradeable)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/governance/implementation/GovernedUUPSProxyImplementation.sol)

### <a name="L-9"></a>[L-9] Upgradeable contract not initialized
Upgradeable contracts are initialized via an initializer function rather than by a constructor. Leaving such a contract uninitialized may lead to it being taken over by a malicious user

*Instances (89)*:
```solidity
File: ./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistry.sol

38:     function initialize(IGovernanceSettings _governanceSettings, address _initialGovernance) external {

39:         initialise(_governanceSettings, _initialGovernance);    // also marks as initialized

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistry.sol)

```solidity
File: ./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistryProxy.sol

16:             abi.encodeCall(AgentOwnerRegistry.initialize, (_governanceSettings, _initialGovernance)))

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentOwnerRegistry/implementation/AgentOwnerRegistryProxy.sol)

```solidity
File: ./contracts/agentVault/implementation/AgentVault.sol

7: import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

15: contract AgentVault is ReentrancyGuard, UUPSUpgradeable, IIAgentVault, IERC165 {

20:     bool private initialized;

46:         initialize(_assetManager);

49:     function initialize(IIAssetManager _assetManager) public {

50:         require(!initialized, AlreadyInitialized());

51:         initialized = true;

53:         initializeReentrancyGuard();

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentVault/implementation/AgentVault.sol)

```solidity
File: ./contracts/agentVault/implementation/AgentVaultFactory.sol

26:         agentVault.initialize(_assetManager);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentVault/implementation/AgentVaultFactory.sol)

```solidity
File: ./contracts/assetManager/facets/AssetManagerInit.sol

8: import {SettingsInitializer} from "../library/SettingsInitializer.sol";

23:     error NotInitialized();

34:         ReentrancyGuard.initializeReentrancyGuard();

35:         SettingsInitializer.validateAndSet(_settings);

36:         CollateralTypes.initialize(_initialCollateralTypes);

47:         require(ds.supportedInterfaces[type(IERC165).interfaceId], NotInitialized());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/AssetManagerInit.sol)

```solidity
File: ./contracts/assetManager/facets/CoreVaultClientFacet.sol

60:         state.initialized = true;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/CoreVaultClientFacet.sol)

```solidity
File: ./contracts/assetManager/facets/CoreVaultClientSettingsFacet.sol

23:     error DiamondNotInitialized();

24:     error AlreadyInitialized();

29:         CoreVaultClient.getState().initialized = true;

47:         require(!state.initialized, AlreadyInitialized());

48:         state.initialized = true;

61:         require(ds.supportedInterfaces[type(IERC165).interfaceId], DiamondNotInitialized());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/CoreVaultClientSettingsFacet.sol)

```solidity
File: ./contracts/assetManager/facets/RedemptionTimeExtensionFacet.sol

20:     error AlreadyInitialized();

21:     error DiamondNotInitialized();

34:         require(ds.supportedInterfaces[type(IERC165).interfaceId], DiamondNotInitialized());

36:         require(RedemptionTimeExtension.redemptionPaymentExtensionSeconds() == 0, AlreadyInitialized());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/facets/RedemptionTimeExtensionFacet.sol)

```solidity
File: ./contracts/assetManager/library/CollateralTypes.sol

21:     error PriceNotInitialized();

27:     function initialize(

144:         require(assetPrice != 0, PriceNotInitialized());

147:             require(tokenPrice != 0, PriceNotInitialized());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/CollateralTypes.sol)

```solidity
File: ./contracts/assetManager/library/CoreVaultClient.sol

40:         bool initialized;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/CoreVaultClient.sol)

```solidity
File: ./contracts/assetManager/library/SettingsInitializer.sol

10: library SettingsInitializer {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/SettingsInitializer.sol)

```solidity
File: ./contracts/assetManagerController/implementation/AssetManagerController.sol

6: import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

17: import {IUUPSUpgradeable} from "../../utils/interfaces/IUUPSUpgradeable.sol";

30:     UUPSUpgradeable,

64:     function initialize(

148:         public override (IUUPSUpgradeable, UUPSUpgradeable)

159:         public payable override (IUUPSUpgradeable, UUPSUpgradeable)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManagerController/implementation/AssetManagerController.sol)

```solidity
File: ./contracts/assetManagerController/implementation/AssetManagerControllerProxy.sol

18:                 AssetManagerController.initialize,

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManagerController/implementation/AssetManagerControllerProxy.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPool.sol

6: import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

25: contract CollateralPool is IICollateralPool, ReentrancyGuard, UUPSUpgradeable, IERC165 {

53:     bool private initialized;

78:         initialize(_agentVault, _assetManager, _fAsset, _exitCollateralRatioBIPS);

81:     function initialize(

89:         require(!initialized, AlreadyInitialized());

90:         initialized = true;

98:         initializeReentrancyGuard();

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPool.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPoolFactory.sol

33:         pool.initialize(_agentVault, address(_assetManager), fAsset,

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPoolFactory.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPoolToken.sol

8: import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

16: contract CollateralPoolToken is IICollateralPoolToken, ERC20, UUPSUpgradeable {

22:     error AlreadyInitialized();

43:     bool private initialized;

59:         initialize(_collateralPool, _tokenName, _tokenSymbol);

62:     function initialize(

69:         require(!initialized, AlreadyInitialized());

70:         initialized = true;

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPoolToken.sol)

```solidity
File: ./contracts/collateralPool/implementation/CollateralPoolTokenFactory.sol

29:         poolToken.initialize(address(_pool), tokenName, tokenSymbol);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/collateralPool/implementation/CollateralPoolTokenFactory.sol)

```solidity
File: ./contracts/coreVaultManager/implementation/CoreVaultManager.sol

120:     function initialize(

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/coreVaultManager/implementation/CoreVaultManager.sol)

```solidity
File: ./contracts/coreVaultManager/implementation/CoreVaultManagerProxy.sol

23:                 CoreVaultManager.initialize,

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/coreVaultManager/implementation/CoreVaultManagerProxy.sol)

```solidity
File: ./contracts/diamond/library/LibDiamond.sol

79:         initializeDiamondCut(_init, _calldata);

158:     function initializeDiamondCut(address _init, bytes memory _calldata) internal {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/diamond/library/LibDiamond.sol)

```solidity
File: ./contracts/fassetToken/implementation/FAsset.sol

10: import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

20: contract FAsset is IIFAsset, IERC165, ERC20, CheckPointable, UUPSUpgradeable, ERC20Permit {

22:     error AlreadyInitialized();

63:     bool private _initialized;

74:         _initialized = true;

78:     function initialize(

87:         require(!_initialized, AlreadyInitialized());

88:         _initialized = true;

95:         initializeV1r1();

98:     function initializeV1r1() public {

101:         initializeEIP712(_name, "1");

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/implementation/FAsset.sol)

```solidity
File: ./contracts/fassetToken/implementation/FAssetProxy.sol

18:             abi.encodeCall(FAsset.initialize, (_name, _symbol, _assetName, _assetSymbol, _decimals))

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/implementation/FAssetProxy.sol)

```solidity
File: ./contracts/ftso/implementation/FtsoV2PriceStore.sol

94:         GovernedUUPSProxyImplementation()   // marks as initialized

98:     function initialize(

111:         initialise(_governanceSettings, _initialGovernance);    // also marks as initialized

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/ftso/implementation/FtsoV2PriceStore.sol)

```solidity
File: ./contracts/ftso/implementation/FtsoV2PriceStoreProxy.sol

20:             abi.encodeCall(FtsoV2PriceStore.initialize, (

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/ftso/implementation/FtsoV2PriceStoreProxy.sol)

```solidity
File: ./contracts/governance/implementation/GovernedBase.sol

106:         require(state.initialised == false, GovernedAlreadyInitialized());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/governance/implementation/GovernedBase.sol)

```solidity
File: ./contracts/governance/implementation/GovernedUUPSProxyImplementation.sol

4: import { UUPSUpgradeable } from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

6: import { IUUPSUpgradeable } from "../../utils/interfaces/IUUPSUpgradeable.sol";

12:     UUPSUpgradeable,

14:     IUUPSUpgradeable

24:         public override (IUUPSUpgradeable, UUPSUpgradeable)

35:         public payable override (IUUPSUpgradeable, UUPSUpgradeable)

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/governance/implementation/GovernedUUPSProxyImplementation.sol)

```solidity
File: ./contracts/userInterfaces/IAgentVault.sol

12:     error AlreadyInitialized();

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/IAgentVault.sol)

```solidity
File: ./contracts/userInterfaces/ICollateralPool.sol

52:     error AlreadyInitialized();

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/userInterfaces/ICollateralPool.sol)


## Medium Issues


| |Issue|Instances|
|-|:-|:-:|
| [M-1](#M-1) | `block.number` means different things on different L2s | 12 |
| [M-2](#M-2) | Centralization Risk for trusted owners | 1 |
### <a name="M-1"></a>[M-1] `block.number` means different things on different L2s
On Optimism, `block.number` is the L2 block number, but on Arbitrum, it's the L1 block number, and `ArbSys(address(100)).arbBlockNumber()` must be used. Furthermore, L2 block numbers often occur much more frequently than L1 block numbers (any may even occur on a per-transaction basis), so using block numbers for timing results in inconsistencies, especially when voting is involved across multiple chains. As of version 4.9, OpenZeppelin has [modified](https://blog.openzeppelin.com/introducing-openzeppelin-contracts-v4.9#governor) their governor code to use a clock rather than block numbers, to avoid these sorts of issues, but this still requires that the project [implement](https://docs.openzeppelin.com/contracts/4.x/governance#token_2) a [clock](https://eips.ethereum.org/EIPS/eip-6372) for each L2.

*Instances (12)*:
```solidity
File: ./contracts/assetManager/library/data/PaymentReference.sol

74:         return uint64(block.number % ID_RANDOMIZATION + 1);

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/assetManager/library/data/PaymentReference.sol)

```solidity
File: ./contracts/fassetToken/implementation/CheckPointable.sol

77:         uint256 newBalance = balanceOfAt(_owner, block.number) - _amount;

80:         totalSupply.writeValue(totalSupplyAt(block.number) - _amount);

90:         uint256 newBalance = balanceOfAt(_owner, block.number) + _amount;

93:         totalSupply.writeValue(totalSupplyAt(block.number) + _amount);

127:         require(_blockNumber < block.number, CleanupBlockMustBeInThePast());

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/implementation/CheckPointable.sol)

```solidity
File: ./contracts/fassetToken/library/CheckPointHistory.sol

91:         if (_blockNumber >= block.number || _blockNumber >= _self.checkpoints[historyCount - 1].fromBlock) {

137:                 CheckPoint({ fromBlock: block.number.toUint64(), value: _toUint192(_value) });

144:             if (block.number == lastBlock) {

149:                 assert (block.number > lastBlock);

152:                     CheckPoint({ fromBlock: block.number.toUint64(), value: _toUint192(_value) });

153:                 _self.endIndex = uint64(historyCount + 1);  // 64 bit safe, because historyCount <= block.number

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/fassetToken/library/CheckPointHistory.sol)

### <a name="M-2"></a>[M-2] Centralization Risk for trusted owners

#### Impact:
Contracts have owners with privileged rights to perform admin tasks and need to be trusted to not perform malicious updates or drain funds.

*Instances (1)*:
```solidity
File: ./contracts/agentVault/implementation/AgentVault.sol

28:     modifier onlyOwner {

```
[Link to code](https://github.com/code-423n4/2025-08-flare/blob/main/./contracts/agentVault/implementation/AgentVault.sol)
