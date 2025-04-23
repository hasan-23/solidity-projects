// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {
    struct Candidate {
        string name;
        uint voteCount;
    }

    address public owner;
    mapping(uint => Candidate) public candidates;
    uint public candidateCount;

    mapping(address => bool) public hasVoted;

    event CandidateAdded(uint id, string name);
    event VoteCast(address voter, uint candidateId);

    constructor() {
        owner = msg.sender;
    }

    function addCandidate(string memory _name) public {
        require(msg.sender == owner, "Only owner can add candidates");
        candidates[candidateCount] = Candidate(_name, 0);
        emit CandidateAdded(candidateCount, _name);
        candidateCount++;
    }

    function vote(uint _candidateId) public {
        require(!hasVoted[msg.sender], "You have already voted");
        require(_candidateId < candidateCount, "Invalid candidate");

        candidates[_candidateId].voteCount++;
        hasVoted[msg.sender] = true;

        emit VoteCast(msg.sender, _candidateId);
    }

    function getCandidate(uint _candidateId) public view returns (string memory, uint) {
        Candidate memory c = candidates[_candidateId];
        return (c.name, c.voteCount);
    }
}
