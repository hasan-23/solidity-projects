// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AccessVault {
    address public owner;

    // Sets the deployer as the contract owner
    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict access to only the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Access denied: not the owner");
        _;
    }

    // Event emitted when ETH is deposited
    event Deposited(address indexed sender, uint amount);

    // Event emitted when ETH is withdrawn
    event Withdrawn(address indexed receiver, uint amount);

    // Allows the owner to deposit ETH into the contract
    function deposit() public payable onlyOwner {
        require(msg.value > 0, "Must send ETH to deposit");
        emit Deposited(msg.sender, msg.value);
    }

    // Allows the owner to withdraw a specified amount of ETH
    function withdraw(uint _amount) public onlyOwner {
        require(_amount > 0, "Withdraw amount must be greater than 0");
        require(address(this).balance >= _amount, "Insufficient contract balance");

        payable(msg.sender).transfer(_amount);
        emit Withdrawn(msg.sender, _amount);
    }

    // Returns the current balance of the contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
