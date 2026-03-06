// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {SimpleStorage} from "./SimpleStorage.sol";

contract StorageFactory{
    SimpleStorage[] public listOfsimpleStorageContracts;

    function createSimpleStorageContract() public{
        SimpleStorage newSimpleStotageContract = new SimpleStorage();
        listOfsimpleStorageContracts.push(newSimpleStotageContract);
    }

    // this function interacts with a function in the SimpleStorage contract
    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {
        // interacting with a contract can be done via the contract address and its ABI
        SimpleStorage simpleStorageContract = listOfsimpleStorageContracts[_simpleStorageIndex];
        simpleStorageContract.store(_newSimpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
        SimpleStorage simpleStorageContract = listOfsimpleStorageContracts[_simpleStorageIndex];
        return simpleStorageContract.retrieve();
    }
}