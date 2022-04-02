// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;
import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MetaToken is ERC20 {
    constructor() ERC20("MetaToken", "MTK") {}

    function mint(uint256 amount) internal {
        _mint(address(this), amount);
    }

    function swapToToken() payable public {
        require(msg.value != 0);
        mint(msg.value);
        console.log(msg.value,balanceOf(address(this)));
        //transferFrom(address(this), msg.sender, msg.value);
        this.transfer(msg.sender, msg.value);
    }
    
}