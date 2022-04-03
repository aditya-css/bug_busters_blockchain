// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;
import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MetaToken is ERC20 {
    uint256 private rate = 3400;
    mapping(string => bytes32) public tokenType;

    constructor() ERC20("MetaToken", "META") {
        tokenType["ETH"] = keccak256(abi.encodePacked("ETH"));
        tokenType["DAI"] = keccak256(abi.encodePacked("DAI"));
        tokenType["META"] = keccak256(abi.encodePacked("META"));
    }

    event tokenMinted(uint256 _amount);
    event swappedToToken(address _user, uint256 _amount);
    event swappedToEther(address _user, uint256 _amount);


    modifier validToken(string memory _type){
        require(tokenType[_type] != bytes32(0));
        _;
    }
    /**
     * @dev function to mint ERC20 Tokens
     * @param _amount The total amount of tokens to mint
     */
    function mint(uint256 _amount) internal {
        _mint(address(this), _amount);

        emit tokenMinted(_amount);
    }

    function swapToken(string memory _from, string memory _to,uint256 _amount,address _contractAddress) external validToken(_from) validToken(_to) {
       if(tokenType[_from] == tokenType['ETH'] && tokenType[_to] == tokenType['META']){
            this.swapToToken(address _contractAddress, _amount);
       }
       if(tokenType[_from] == tokenType['META'] && tokenType[_to] == tokenType['ETH']){
            this.swapToEth(_amount);
       }
       if(tokenType[_from] == tokenType['DAI'] && tokenType[_to] == tokenType['META']){
            this.swapToToken(address _contractAddress, _amount);
       }
       if(tokenType[_from] == tokenType['META'] && tokenType[_to] == tokenType['DAI']){
            this.swapToToken(address _contractAddress, _amount);
       }
    }

    }

    /**
     * @dev function swap ethers to ERC20 tokens
     */
    function swapToToken(address _contractAddress) public payable {
        require(msg.value != 0);
        uint256 tokenamount = msg.value;
        mint(tokenamount);
        uint256 previousAllowance = allowance(msg.sender, _contractAddress);
        approve(_contractAddress, previousAllowance + tokenamount);
        this.transfer(msg.sender, tokenamount);
        emit swappedToToken(msg.sender, tokenamount);
    }

    /**
     * @dev function swap ERC20 tokens to ethers
     */
    function swapToEth(uint256 _amount) public {
        require(_amount != 0);
        payable(msg.sender).transfer(_amount);
        _burn(address(this), _amount);
        emit swappedToEther(msg.sender, _amount);
    }
}
