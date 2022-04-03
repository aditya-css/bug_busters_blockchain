// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;
import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MetaToken is ERC20 {
    constructor() ERC20("MetaToken", "META") {}

    /**
     * @dev Event Emitted when Tokens are minted
     *  @param _amount Amount of tokens minted
     */
    event tokenMinted(uint256 _amount);

    /**
     * @dev Event Emitted when ethers are swapped for tokens
     @param _user The address of the user
     @param _amount The amount of tokens minted
     */
    event swappedToToken(address _user, uint256 _amount);

    /**
     * @dev Event Emitted when Tokens are swapped for Ethers
     * @param _user The address of the user
     * @param _amount The amount of tokens swapped
     */
    event swappedToEther(address _user, uint256 _amount);

    /**
     * @dev function swap ethers to ERC20 tokens
     */
    function ethToToken() public payable {
        require(msg.value != 0);
        uint256 tokenamount = msg.value;

        _mint(address(this), tokenamount);
        emit tokenMinted(tokenamount);

        this.transfer(msg.sender, tokenamount);
        emit swappedToToken(msg.sender, tokenamount);
    }

    /**
     * @dev function swap ERC20 tokens to ethers
     * @param _amount The amount of tokens to swap
     */
    function tokenToEth(uint256 _amount) public {
        require(_amount != 0);
        payable(msg.sender).transfer(_amount);
        _burn(address(this), _amount);
        emit swappedToEther(msg.sender, _amount);
    }
}
