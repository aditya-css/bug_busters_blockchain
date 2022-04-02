//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MetaStack {
    uint256 public listingFee;
    
    constructor() {
        listingFee = 0.1 ether;
    }
    
    function sendEth(address _to) external payable {
        require(msg.value > 0, "Amount must be greater than 0");
        require(msg.sender != _to, "Cannot send to yourself");
        require(msg.sender != address(0), "Cannot send to the null address");
        console.log(address(this).balance);
        payable(_to).transfer(msg.value);
    }
}