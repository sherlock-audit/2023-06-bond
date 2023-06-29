# Option System

Smart contracts for Option Token (oToken) Liquidity Mining.

Read the [full developer documentation](https://docs.bondprotocol.finance/smart-contracts/overview) at docs.bondprotocol.finance

## Background

Our mission [began as a paradigm shift](https://medium.com/@Bond_Protocol/introducing-bond-protocol-8476881f84e4) in the way protocols utilize emissions to acquire assets, own liquidity, and diversify their treasuries. Liquidity mining incentives are still, for better or worse, widely utilized in crypto to incentivize early network participants providing a valuable service - liquidity.

But incentives naturally attract short-term participants and [mercenary capital](https://www.nansen.ai/research/all-hail-masterchef-analysing-yield-farming-activity). Liquidity is also inherently temporary, a good mental model is that LM incentives "rent" liquidity.

**Recontextualizing liquidity mining incentives as call options unlocks the ability for protocols to capture value and own their liquidity.**

This implementation draws inspiration from a number of sources including:

-   Andre Cronje - [Liquidity Mining Rewards v2](https://andrecronje.medium.com/liquidity-mining-rewards-v2-50896e44f259)
-   TapiocaDAO - [R.I.P Liquidity Mining](https://mirror.xyz/tapiocada0.eth/CYZVxI_zyislBjylOBXdE2nS-aP-ZxxE8SRgj_YLLZ0)
-   Timeless Finance - [Bunni oLIT](https://docs.bunni.pro/docs/tokenomics/olit)

## Overview

Bond Protocol's Option System is a flexible system for unlocking the power of Option Token Liquidity Mining (OTLM) for projects of all sizes. We incorporated insights gained from bonding, notably designing a system that can be used with or without a price oracle.

### FixedStrikeOptionToken.sol

ERC20 implementation of a Fixed-Strike Option Token. When the token is created, strike price is set to a fixed exchange rate between two ERC20 tokens - the Payout and Quote tokens. Option tokens inherit the units of the Payout token, and they are created 1:1. The Strike Price is provided in Quote token units and is formatted as the number of Quote tokens per Payout token. Timestamps are used to determine when the option is Eligible to be exercised and its Expiry, beyond which it cannot be exercised. The interplay between Eligible and Expiry times gives rise to the entire design space between American-style and European-style options.

![Lifecycle of an Option Token](./assets/Lifecycle%20of%20an%20oToken.png)

### FixedStrikeOptionTeller.sol

The Teller contract handles token accounting and manages interactions with end users exercising options. Option tokens can be permissionlessly deployed and created by depositing the appropriate quantity of tokens as collateral. Option tokens can be used as incentives via the OTLM contracts, used within an existing ERC20 reward contract, or sold via a bond market (likely in an instant swap). Users can exercise their options by providing the appropriate quantity of tokens as payment alongside Eligible (but not Expired) option tokens. Exercised option tokens are burned after being provided to the Teller. After Expiry, the Receiver can reclaim collateral from unexercised options. Receivers can unwrap option tokens they possess at any time via the exercise function.

### OTLM.sol

Option Token Liquidity Mining (OTLM) implementation that manages option token rewards via an epoch-based system. OTLM instances are deployed with immutable Staked Token (ex: LP token), Payout Token, and Option Teller addresses. Owners manage parameters used to create Option Tokens for a given epoch, as well as that epoch's duration and reward rate. Strike price can be set for the next epoch via a Manual implementation (only Owner) or based on a set discount from Oracle price. Once configured, Owners can enable deposits for LM. Owners can also withdraw Payout Tokens at any time.

Users can stake and unstake tokens at any time. An emergency unstake function is provided for edge cases, but users will forfeit all rewards if stake is withdrawn using this function. Rewards can be claimed for each eligible epoch. Option tokens which have already expired are not claimed in order to save on gas costs.

New epochs can be triggered manually by the Owner, or they can be started when users call a function that tries to start a new epoch. If a user starts a new epoch, they are sent Option Tokens as the Epoch Transition Reward in order to compensate for increased gas cost paid.

### OTLMFactory.sol

Factory contract will deploy instances of OTLM contracts. Owners provide the Staked Token and Payout Token addresses, as well as the Style of OTLM - Manual Strike or Oracle Strike.

## Getting Started

This repository uses Foundry as its development and testing environment. You must first [install Foundry](https://getfoundry.sh/) to build the contracts and run the test suite.

### Clone the repository into a local directory

```sh
$ git clone https://github.com/Bond-Protocol/options
```

### Install dependencies

```sh
$ cd options
$ npm install # install npm modules for linting
$ forge build # installs git submodule dependencies when contracts are compiled
```

## Build

Compile the contracts with `forge build`.

## Tests

Run the full test suite with `forge test`.

Fuzz tests have been written to cover certain input checks. Default number of runs is 4096.

## Linting

Pre-configured `solhint` and `prettier-plugin-solidity`. Can be run by

```sh
$ npm run lint
```

Run lint before committing.

### CI with Github Actions

Automatically run linting and tests on pull requests.

## Audits

The smart contracts in this repository were audited by... The comprehensive audit reports can be found in the `audit/` directory.

## License

The source code of this project is licensed under the [AGPL 3.0 license](LICENSE.md)
