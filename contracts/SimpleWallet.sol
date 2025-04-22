// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleWallet {
    mapping(address => uint) public balances;

    event Deposited(address indexed user, uint amount);
    event Withdrawn(address indexed user, uint amount);

    function deposit() public payable {
        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    function withdraw(uint _amount) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        emit Withdrawn(msg.sender, _amount);
    }

    function getBalance() public view returns (uint) {
        return balances[msg.sender];
    }
}
