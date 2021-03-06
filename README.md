# PundiX Selection Test

This repo is a selection test from the PundiX HR team.  The following is an extract from the original email I received.

> As a preliminary selection, we would like to invite you to complete our first test.
>
> Please create a basic smart contract in Ethereum Testnet (ropsten) and create your own token (for example, Token “YOURNAME”) 
>
> You will need to:
> - put an initial supply of 1,000,000 tokens
> - add a mint function and mint another 1,000,000 tokens using this function
> - add a token burn function and burn 500,000 token by sending tokens into this function
> - create a lock function. eg: send your tokens to an address (wallet A) from the contract address / token owner. You can lock wallet A, so wallet A cannot move the tokens.
>
> For mint, burn and lock function, please execute it in a smart contract.

There are a few assumptions I had to make regarding the above requirements.
- The initial supply of tokens will reside within the token contract address
- Mint, burn and lock functions will not have any access control to facilitate testing by the PundiX team
- Only Ether can be send to a payable function, I implemented `sending tokens into this function` as a burn function accepting the address to burn from and amount of tokens to burn 

I used Remix's flatten extension to combine all dependencies into a single Solidity file. After which, I had to remove any duplicate license identifiers (i.e. `// SPDX-License-Identifier: MIT`).  I also had to re-arrange the order which the inherited base contracts/interfaces were declared. The most 'parent' contracts/interfaces must be declared first, followed by the inheriting child contracts/interfaces.

<br/><br/>
![Remix Flatten Extension](/images/readme1.jpg?raw=true)
<br/><br/>

After the single Solidity file is in order and can be compiled in Remix, I published the source code for verification by the PundiX team via [EtherScan](https://ropsten.etherscan.io/verifyContract).
