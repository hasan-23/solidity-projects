// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FunctionBasics {
    // 1️⃣ This variable stores a number
    uint public storedNumber;

    // 2️⃣ This function returns a fixed number (10)
    function getTen() public pure returns (uint) {
        return 10;
    }

    // 3️⃣ This function takes a string and returns it back
    function echoString(string memory _text) public pure returns (string memory) {
        return _text;
    }

    // 4️⃣ This function stores a number into storedNumber
    function setNumber(uint _num) public {
        storedNumber = _num;
    }
}
