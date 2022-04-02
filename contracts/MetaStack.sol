//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./MetaToken.sol";

contract MetaStack {
    uint256 public listingFee;
    
    constructor() {
        listingFee = 0.1 ether;
    }
    
    /**
     @dev Event Emitted when Ethers are sent as reward
     */
    event EthersSent(address _to, uint256 _amount);

    /**
     @dev Event Emitted when Tokens are sent as reward
     */
    event TokensSent(address _to, uint256 _amount);

    /**
     @dev Function to Send Ethers to the recepient
     */
    function sendEth(address _to) external payable {
        require(msg.value > 0, "Amount must be greater than 0");
        require(msg.sender != _to, "Cannot send to yourself");
        require(msg.sender != address(0), "Cannot send to the null address");
        payable(_to).transfer(msg.value);
    }

    /**
     @dev Function to Send Tokens to the recepient
     */
    function sendToken(address _to, address _contractAddress, uint256 _amount) external {
        require(_amount > 0, "Amount must be greater than 0");
        require(msg.sender != _to, "Cannot send to yourself");
        require(msg.sender != address(0), "Cannot send to the null address");
        IERC20(_contractAddress).transferFrom(address(msg.sender), _to, _amount);
    }
}