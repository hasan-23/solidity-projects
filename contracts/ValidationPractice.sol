// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ValidationPractice {
    address public owner;
    mapping(address => uint256) public balance;
    bool public paused;

    // Custom Errors
    error NotOwner();
    error InvalidAmount();
    error ContractPaused();
    error InsufficientFunds();

    constructor() {
        owner = msg.sender;
    }

    // Deposit ETH into contract
    function deposit() external payable {
        if (msg.value == 0) revert InvalidAmount();
        balance[msg.sender] += msg.value;
    }

    // Withdraw ETH (only when not paused)
    function withdraw(uint256 amount) external {
        if (paused) revert ContractPaused();
        if (amount == 0) revert InvalidAmount();
        if (balance[msg.sender] < amount) revert InsufficientFunds();

        balance[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    // Only owner can pause/unpause
    function setPause(bool _paused) external {
        if (msg.sender != owner) revert NotOwner();
        paused = _paused;
    }

    // View current contract state
    function isPaused() external view returns (bool) {
        return paused;
    }

    // View balance of any address
    function getBalance(address user) external view returns (uint256) {
        return balance[user];
    }
}
