pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {

  YourToken yourToken;
  uint256 public constant tokensPerEth = 100;
  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);
  event SellTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

  constructor(address tokenAddress) public {
    yourToken = YourToken(tokenAddress);
  }


  //  a payable buyTokens() function:
  function buyTokens() public payable {
    uint amount = tokensPerEth * msg.value;
    yourToken.transfer(msg.sender,amount);
    emit BuyTokens(msg.sender,msg.value,amount);


  }


  //  a withdraw() function that lets the owner withdraw ETH
  function withdraw() public onlyOwner {
    payable(msg.sender).transfer(address(this).balance);
  }




  // ToDo: create a sellTokens() function:
  function sellTokens(uint256 theAmount) public {
 
  yourToken.transferFrom(msg.sender,address(this), theAmount );
  uint etherAmount = theAmount/ tokensPerEth;
  payable(msg.sender).transfer(etherAmount);
  emit SellTokens(msg.sender,etherAmount,theAmount);

  }


}
