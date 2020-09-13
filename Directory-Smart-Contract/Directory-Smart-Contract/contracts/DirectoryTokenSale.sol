// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

import "./Directory.sol";

contract DirectoryTokenSale {
    address          admin;
    Directory public tokenContract;
    uint256   public tokenPrice; // in wei
    uint256   public tokensSold;

    event Sell(address _buyer, uint256 _amount);

    constructor(Directory _tokenContract, uint256 _tokenPrice) public {
        admin = msg.sender;
        tokenContract = _tokenContract;
        tokenPrice = _tokenPrice;
    }

    function multiply(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x);
    }

    function buyTokens(uint256 _numberOfTokens) public payable {
        require(msg.value == multiply(_numberOfTokens, tokenPrice));
        require(tokenContract.balanceOf(address(this)) >= _numberOfTokens);
        require(tokenContract.transfer(msg.sender, _numberOfTokens));

        tokensSold += _numberOfTokens;

        Sell(msg.sender, _numberOfTokens);
    }


    function endSale() public payable {
        require(msg.sender == admin);
        require(tokenContract.transfer(admin, tokenContract.balanceOf(address(this))));

        selfdestruct(msg.sender);
    }
}