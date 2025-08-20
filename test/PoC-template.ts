import { ZERO_ADDRESS } from "../deployment/lib/deploy-utils";
import { PaymentReference } from "../lib/fasset/PaymentReference";
import { Agent } from "../lib/test-utils/actors/Agent";
import { AssetContext } from "../lib/test-utils/actors/AssetContext";
import { CommonContext } from "../lib/test-utils/actors/CommonContext";
import { Liquidator } from "../lib/test-utils/actors/Liquidator";
import { Minter } from "../lib/test-utils/actors/Minter";
import { Redeemer } from "../lib/test-utils/actors/Redeemer";
import { testChainInfo } from "../lib/test-utils/actors/TestChainInfo";
import { MockChain } from "../lib/test-utils/fasset/MockChain";
import { MockFlareDataConnectorClient } from "../lib/test-utils/fasset/MockFlareDataConnectorClient";
import { expectEvent, expectRevert, time } from "../lib/test-utils/test-helpers";
import { getTestFile, loadFixtureCopyVars } from "../lib/test-utils/test-suite-helpers";
import { assertWeb3Equal } from "../lib/test-utils/web3assertions";
import { filterEvents, requiredEventArgs } from "../lib/utils/events/truffle";
import { deepFormat, toBIPS, toBN, toBNExp, toWei } from "../lib/utils/helpers";

// based on test/integration/assetManager/AttackScenarios.ts

contract(`AssetManager.sol; ${getTestFile(__filename)}; Asset manager integration tests`, accounts => {
    const governance = accounts[10];
    const agentOwner1 = accounts[20];
    const agentOwner2 = accounts[21];
    const minterAddress1 = accounts[30];
    const minterAddress2 = accounts[31];
    const redeemerAddress1 = accounts[40];
    const redeemerAddress2 = accounts[41];
    const challengerAddress1 = accounts[50];
    const challengerAddress2 = accounts[51];
    const liquidatorAddress1 = accounts[60];
    const liquidatorAddress2 = accounts[61];
    // addresses on mock underlying chain can be any string, as long as it is unique
    const underlyingAgent1 = "Agent1";
    const underlyingAgent2 = "Agent2";
    const underlyingMinter1 = "Minter1";
    const underlyingMinter2 = "Minter2";
    const underlyingRedeemer1 = "Redeemer1";
    const underlyingRedeemer2 = "Redeemer2";

    let commonContext: CommonContext;
    let context: AssetContext;
    let mockChain: MockChain;
    let mockFlareDataConnectorClient: MockFlareDataConnectorClient;

    async function initialize() {
        commonContext = await CommonContext.createTest(governance);
        context = await AssetContext.createTest(commonContext, testChainInfo.eth);
        return { commonContext, context };
    }

    beforeEach(async () => {
        ({ commonContext, context } = await loadFixtureCopyVars(initialize));
        mockChain = context.chain as MockChain;
        mockFlareDataConnectorClient = context.flareDataConnectorClient as MockFlareDataConnectorClient;
    });

    it("PoC: bad things can happen when xyz", async () => {
        // Prove how bad things can happen:



    });

});
