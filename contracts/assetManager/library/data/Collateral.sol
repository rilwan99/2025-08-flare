// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;


library Collateral {
    enum Kind {
        VAULT,   // vault collateral (tokens in in agent vault)
        POOL,           // pool collateral (NAT)
        AGENT_POOL      // agent's pool tokens (expressed in NAT) - only important for minting
    }

    struct Data {
        Kind kind;
        // represent the amount of tokens
        uint256 fullCollateral;
        // price ratio that tells us how many wei units of collateral token equals 1 AMG unit
        uint256 amgToTokenWeiPrice;
    }

    struct CombinedData {
        Collateral.Data agentCollateral;
        Collateral.Data poolCollateral;
        Collateral.Data agentPoolTokens;
    }
}
