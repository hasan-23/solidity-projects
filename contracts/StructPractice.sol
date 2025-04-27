// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StructPractice {
    struct Wallet {
        uint balance;
        address walletAddress;
    }

    struct User {
        string username;
        Wallet walletInfo;
    }

    User[] public users;

    // Add a new user with wallet details
    function addUser(string memory _username, uint _balance) public {
        Wallet memory newWallet = Wallet(_balance, msg.sender);
        User memory newUser = User(_username, newWallet);
        users.push(newUser);
    }

    // Get user's wallet balance by index
    function getUserBalance(uint _index) public view returns (uint) {
        return users[_index].walletInfo.balance;
    }

    // Get user's wallet address by index
    function getUserWalletAddress(uint _index) public view returns (address) {
        return users[_index].walletInfo.walletAddress;
    }
}
