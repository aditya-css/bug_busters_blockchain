// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;
import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MetaToken is ERC20 {
    constructor() ERC20("MetaToken", "META") {}

    event tokenMinted(uint _amount);
    event swappedToToken(address _user, uint256 _amount);
    event swappedToEther(address _user, uint256 _amount);

    /**
        * @dev function to mint ERC20 Tokens
        * @param _amount The total amount of tokens to mint        
    */
    function mint(uint256 _amount) internal {
        _mint(address(this), _amount);
        
        emit tokenMinted(_amount);
    }

    /**
        * @dev function swap ethers to ERC20 tokens
    */
    function swapToToken(address _contractAddress) payable public {
        require(msg.value != 0);
        uint tokenamount=msg.value;
        mint(tokenamount);
        uint256 previousAllowance = allowance(msg.sender, _contractAddress);
        approve(_contractAddress, previousAllowance + tokenamount);
        this.transfer(msg.sender, tokenamount);
        emit swappedToToken(msg.sender, tokenamount);
    }
    
    /**
        * @dev function swap ERC20 tokens to ethers
    */
    function swapToEth  (uint _amount) public {
        require(_amount != 0);
        payable(msg.sender).transfer(_amount);
        _burn(address(this), _amount);
        emit swappedToEther(msg.sender, _amount);
    }
    
}