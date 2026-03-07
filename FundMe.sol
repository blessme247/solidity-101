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

    function fund() public payable {
        // Allow users to send $
        // Have a minimum $ sent
        
        require(msg.value.getConversionRate() >= minimumUsd, "You need to spend more ETH!");
       
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

   
}