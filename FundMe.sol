// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;
    uint256 minimumUsd = 5e18;

    address[] public funders; 

     // Store the amount funded
     // Address -> Amount
     // We can use a mapping
    mapping(address => uint256) public addressToAmountFunded;

    address public owner;

    constructor(){
        owner = msg.sender;
    }

    function fund() public payable {
        // Allow users to send $
        // Have a minimum $ sent
        
        require(msg.value.getConversionRate() >= minimumUsd, "You need to spend more ETH!");
       
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    function withdraw() public onlyOwner {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
            payable(funder).transfer(address(this).balance);
        }
        // reset the array
        funders = new address[](0);

        // to send blockchain currencies, there are 3 ways
        // 1. transfer()
        payable(msg.sender).transfer(address(this).balance);
        // 2. send()
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess, "Send Failed");
        // 3. call()
        (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "Call Failed");
    }

    modifier onlyOwner{
        require(msg.sender == owner, "Must be owner!");
        _;
    }

   
}