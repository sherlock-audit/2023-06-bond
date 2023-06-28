// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.15;

import {OptionToken, ERC20} from "src/bases/OptionToken.sol";

/// @title Fixed Strike Option Token
/// @notice Fixed Strike Option Token Contract (ERC-20 compatible)
///
/// @dev The Fixed Strike Option Token contract is issued by a
///      Fixed Strike Option Token Teller to represent traditional
///      American-style options on the underlying token with a fixed strike price.
///
///      Call option tokens can be exercised for the underlying token 1:1
///      by paying the amount * strike price in the quote token
///      at any time between the eligible and expiry timestamps.
///
/// @dev This contract uses Clones (https://github.com/wighawag/clones-with-immutable-args)
///      to save gas on deployment and is based on VestedERC20 (https://github.com/ZeframLou/vested-erc20)
///
/// @author Bond Protocol
contract FixedStrikeOptionToken is OptionToken {
    /* ========== IMMUTABLE PARAMETERS ========== */

    /// @notice The strike price of the option
    /// @return _strike The option strike price specified in the amount of quote tokens per underlying token
    function strike() public pure returns (uint256 _strike) {
        return _getArgUint256(0x9e);
    }

    /* ========== VIEW ========== */

    function getOptionParameters()
        external
        pure
        returns (
            ERC20 payout_,
            ERC20 quote_,
            uint48 eligible_,
            uint48 expiry_,
            address receiver_,
            bool call_,
            uint256 strike_
        )
    {
        return (payout(), quote(), eligible(), expiry(), receiver(), call(), strike());
    }
}
