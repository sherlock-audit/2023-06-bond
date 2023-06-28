
# Bond Update #2 contest details

- Join [Sherlock Discord](https://discord.gg/MABEWyASkp)
- Submit findings using the issue page in your private contest repo (label issues as med or high)
- [Read for more details](https://docs.sherlock.xyz/audits/watsons)

# Q&A

### Q: On what chains are the smart contracts going to be deployed?
Mainnet, Arbitrum, Optimism
___

### Q: Which ERC20 tokens do you expect will interact with the smart contracts? 
Any. Must conform to ERC20 metadata with `string memory name`, `string memory symbol`, `uint8 decimals` variables.
___

### Q: Which ERC721 tokens do you expect will interact with the smart contracts? 
None
___

### Q: Which ERC777 tokens do you expect will interact with the smart contracts? 
None
___

### Q: Are there any FEE-ON-TRANSFER tokens interacting with the smart contracts?

No. Fee-on-transfer tokens are not supported.
___

### Q: Are there any REBASING tokens interacting with the smart contracts?

No. Rebasing tokens are not supported.
___

### Q: Are the admins of the protocols your contracts integrate with (if any) TRUSTED or RESTRICTED?
TRUSTED
___

### Q: Is the admin/owner of the protocol/contracts TRUSTED or RESTRICTED?
TRUSTED
___

### Q: Are there any additional protocol roles? If yes, please explain in detail:
The Option Teller has permissioned functions that are controlled by the Bond Protocol RolesAuthority contract. The Bond Protocol MS is the only permissioned contract on the authority.
___

### Q: Is the code/contract expected to comply with any EIPs? Are there specific assumptions around adhering to those EIPs that Watsons should be aware of?
Option Token is expected to conform to ERC-20.
___

### Q: Please list any known issues/acceptable risks that should not result in a valid finding.
None.
___

### Q: Please provide links to previous audits (if any).
These contracts have not been audited previously. Several library contracts which are used here were used in the previously audited Bond Protocol systems (Clones, FullMath, TransferHelper). Additionally, the design of the Option Teller is similar to the Bond Protocol Fixed Expiry Teller which has been audited.
- [Sherlock Audit Update 03/2023](https://github.com/Bond-Protocol/bond-contracts/blob/master/audits/Sherlock/Bond_Protocol_Update_Audit_Report.pdf)
- [Sherlock Audit 11/2022](https://github.com/Bond-Protocol/bond-contracts/blob/master/audits/Sherlock/Bond_Final_Report.pdf)
- [Zellic Audit 11/2022](https://github.com/Bond-Protocol/bond-contracts/blob/master/audits/Zellic/Bond%20Protocol%20Threat%20Model.pdf)
___

### Q: Are there any off-chain mechanisms or off-chain procedures for the protocol (keeper bots, input validation expectations, etc)?
None.
___

### Q: In case of external protocol integrations, are the risks of external contracts pausing or executing an emergency withdrawal acceptable? If not, Watsons will submit issues related to these situations that can harm your protocol's functionality.
Yes. The only potential external integration are oracle price feeds. Validation and handling of outages must be done in the user's IBondOracle implementation. Examples have been provided or them at https://github.com/Bond-Protocol/issuer-contracts.
___

### Q: Do you expect to use any of the following tokens with non-standard behaviour with the smart contracts?
The protocol is permissionless. Fee-on-transfer is explicitly prohibited in the code. Our documentation will reflect that rebasing tokens and tokens without string metadata are not supported. Odd decimal values are supported, though could result in precision loss. 
___

### Q: Add links to relevant protocol resources
https://docs.bondprotocol.finance
___



# Audit scope


[options @ d43df2029831cf2647d9a720f40a7055fa03a6a0](https://github.com/Bond-Protocol/options/tree/d43df2029831cf2647d9a720f40a7055fa03a6a0)
- [options/src/bases/OptionToken.sol](options/src/bases/OptionToken.sol)
- [options/src/fixed-strike/FixedStrikeOptionTeller.sol](options/src/fixed-strike/FixedStrikeOptionTeller.sol)
- [options/src/fixed-strike/FixedStrikeOptionToken.sol](options/src/fixed-strike/FixedStrikeOptionToken.sol)
- [options/src/fixed-strike/liquidity-mining/OTLM.sol](options/src/fixed-strike/liquidity-mining/OTLM.sol)
- [options/src/fixed-strike/liquidity-mining/OTLMFactory.sol](options/src/fixed-strike/liquidity-mining/OTLMFactory.sol)
- [options/src/periphery/TokenAllowlist.sol](options/src/periphery/TokenAllowlist.sol)


