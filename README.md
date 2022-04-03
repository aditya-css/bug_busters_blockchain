# Basic Sample Hardhat Project

This project demonstrates a smart contract development and Testing for MetaStack. Which is a opensource question answer plateform with crypto token appriciation facility.

In this project the MetaToken.sol is the ERC20 Token Contract which also handles the swapping from Eth to META token and vice versa. The MetaStack.sol is the contract which handles the reward transfer functionality. The tests for both the contracts are written in the test directory. Run the tests by the console command given below.

```shell
npm install
npx hardhat compile
npx hardhat node
npx hardhat test
npx hardhat run scripts/deploy.js

```