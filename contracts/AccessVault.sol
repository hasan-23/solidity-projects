// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AccessVault {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Access denied: not the owner");
        _;
    }

    event Deposited(address indexed sender, uint amount);
    event Withdrawn(address indexed receiver, uint amount);

    // Deposit ETH into the contract
    function deposit() public payable onlyOwner {
        require(msg.value > 0, "Must send ETH to deposit");
        emit Deposited(msg.sender, msg.value);
    }

    // Withdraw ETH from the contract
    function withdraw(uint _amount) public onlyOwner {
        require(_amount > 0, "Withdraw amount must be greater than 0");
        require(address(this).balance >= _amount, "Insufficient contract balance");

        payable(msg.sender).transfer(_amount);
        emit Withdrawn(msg.sender, _amount);
    }

    // View current contract balance
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
