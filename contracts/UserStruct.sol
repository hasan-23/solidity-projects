// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserStruct {
    struct User {
        string name;
        uint age;
    }

    mapping(address => User) public users;

    function createUser(string memory _name, uint _age) public {
        users[msg.sender] = User(_name, _age);
    }

    function getMyUser() public view returns (string memory, uint) {
        User memory u = users[msg.sender];
        return (u.name, u.age);
    }
}
