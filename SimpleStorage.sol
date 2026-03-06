// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SimpleStorage {
    uint256 public myFavoriteNumber;

    // uint256[] listOfFavoriteNumbers 
    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    Person[] public listOfPeople;

    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 _favouriteNumber) public virtual  {
        myFavoriteNumber = _favouriteNumber;
    }

    // view, pure
    function retrieve() public view returns(uint256){ // doesnt cost gas since it only retrives the state of the blockchain/contract
        return myFavoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        listOfPeople.push(Person(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}