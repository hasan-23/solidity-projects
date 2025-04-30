// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FundTracker {
    address public owner;
    mapping(address => uint256) public deposits;

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed owner, uint256 amount);

    error NotOwner();
    error NoFunds();

    constructor() {
        owner = msg.sender;
    }

    function deposit() external payable {
        deposits[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    function withdraw() external {
        if (msg.sender != owner) {
            revert NotOwner();
        }

        uint256 contractBalance = address(this).balance;
        if (contractBalance == 0) {
            revert NoFunds();
        }

        payable(owner).transfer(contractBalance);
        emit Withdrawn(owner, contractBalance);
    }

    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
