// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;
import "hardhat/console.sol";
import "github.com/smartcontractkit/chainlink/evm-contracts/src/v0.6/ChainlinkClient.sol";

contract DaiSwap {
    /**
     * @dev function to mint ERC20 Tokens
     * @param _amount The total amount of tokens to mint
     */
    function testApi() public {
        Chainlink.Request memory req = buildChainlinkRequest(
            stringToBytes32(JOBID),
            address(this),
            this.fulfill.selector
        );
        req.add(
            "get",
            "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD"
        );
        req.add("path", "USD");
        req.addInt("times", 100);
    }
}
