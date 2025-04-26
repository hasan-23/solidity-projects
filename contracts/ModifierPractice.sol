// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ModifierPractice {
    address public owner;
    mapping(address => bool) public isAuthorized;
    mapping(address => bool) public hasWithdrawn;

    // Sets the contract owner at deployment
    constructor() {
        owner = msg.sender;
    }

    // Ensures only the owner can call certain functions
    modifier onlyOwner() {
        require(msg.sender == owner, "Access denied: not the owner");
        _;
    }

    // Ensures the caller is authorized
    modifier isAuth() {
        require(isAuthorized[msg.sender], "Not authorized");
        _;
    }

    // Ensures the caller has not already withdrawn
    modifier notWithdrawn() {
        require(!hasWithdrawn[msg.sender], "Already withdrawn");
        _;
    }

    // Event emitted when a user is authorized
    event Authorized(address user);

    // Event emitted when ETH is deposited
    event Deposited(address sender, uint amount);

    // Event emitted when a withdrawal occurs
    event Withdrawn(address receiver, uint amount);

    // Authorizes a user to withdraw funds (only owner can call)
    function authorizeUser(address _user) public onlyOwner {
        isAuthorized[_user] = true;
        emit Authorized(_user);
    }

    // Allows the owner to deposit ETH into the contract
    function deposit() public payable onlyOwner {
        require(msg.value > 0, "Must deposit some ETH");
        emit Deposited(msg.sender, msg.value);
    }

    // Allows an authorized user to withdraw a specified amount
    function withdraw(uint amount) public isAuth notWithdrawn {
        require(amount > 0, "Invalid amount");
        require(address(this).balance >= amount, "Insufficient contract balance");

        payable(msg.sender).transfer(amount);
        hasWithdrawn[msg.sender] = true;

        emit Withdrawn(msg.sender, amount);
    }

    // Returns the current ETH balance of the contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
