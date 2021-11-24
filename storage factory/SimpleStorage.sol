// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0; 

contract SimpleStorage {
    
    //initiatlize as zero
    uint256 favoriteNumber;
    
    struct People {
        uint256 favoriteNumber; 
        string name; 
    }
    
    
    People[] public people; 
    mapping(string => uint256) public name2FavoriteNumber; 
    
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber,_name)); 
        name2FavoriteNumber[_name] = favoriteNumber; 
    
    }
    
    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber; 
    }
    
    function retrieve () public view returns(uint256) {
        return favoriteNumber; 
    }

}