// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ArrayPractice {
    string[] public names;

    // Add a name to the array
    function addName(string memory _name) public {
        names.push(_name);
    }

    // Get a name by index
    function getName(uint _index) public view returns (string memory) {
        return names[_index];
    }

    // Get total number of names
    function getNamesCount() public view returns (uint) {
        return names.length;
    }
}
