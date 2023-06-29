// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.15;

import {ERC20} from "solmate/tokens/ERC20.sol";
import {IFixedStrikeOptionTeller} from "src/interfaces/IFixedStrikeOptionTeller.sol";
import {OTLM, ManualStrikeOTLM, OracleStrikeOTLM} from "src/fixed-strike/liquidity-mining/OTLM.sol";

/// @title Option Token Liquidity Mining (OTLM) Factory
/// @notice Factory for deploying OTLM contracts
/// @dev The OTLM Factory contract allows anyone to deploy new OTLM contracts. When deployed, the owner of the OTLM is set to the caller.
///      There are two OTLM implementations available in the factory: Manual Strike and Oracle Strike.
///      See OTLM.sol for details on the different implementations.
/// @author Bond Protocol
contract OTLMFactory {
    /* ========== ERRORS ========== */
    error Factory_InvalidStyle();

    /* ========== STATE VARIABLES ========== */
    enum Style {
        ManualStrike,
        OracleStrike
    }

    /// @notice Option Teller to be used by OTLM contracts
    IFixedStrikeOptionTeller public immutable optionTeller;

    /* ========== CONSTRUCTOR ========== */

    constructor(IFixedStrikeOptionTeller optionTeller_) {
        optionTeller = optionTeller_;
    }

    /* ========== DEPLOY OTLM CONTRACTS ========== */

    /// @notice Deploy a new OTLM contract with the caller as the owner
    /// @param stakedToken_  ERC20 token that will be staked to earn rewards
    /// @param payoutToken_  ERC20 token that stakers will receive call options for
    /// @param style_        Style of OTLM contract to deploy: Manual Strike or Oracle Strike
    ///                      Manual Strike: Owners must manually update the strike price to change it over time
    ///                      Oracle Strike: Strike price is automatically updated based on an oracle and discount.
    ///                      A minimum strike price can be set on the Oracle Strike version to prevent it from going too low.
    /// @return              Address of the new OTLM contract
    function deploy(ERC20 stakedToken_, ERC20 payoutToken_, Style style_) external returns (OTLM) {
        OTLM otlm;
        if (style_ == Style.ManualStrike) {
            otlm = OTLM(
                address(new ManualStrikeOTLM(msg.sender, stakedToken_, optionTeller, payoutToken_))
            );
        } else if (style_ == Style.OracleStrike) {
            otlm = OTLM(
                address(new OracleStrikeOTLM(msg.sender, stakedToken_, optionTeller, payoutToken_))
            );
        } else {
            revert Factory_InvalidStyle();
        }
        return otlm;
    }
}
