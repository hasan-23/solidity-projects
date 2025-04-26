// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {
    // Represents a candidate with name and total votes
    struct Candidate {
        string name;
        uint voteCount;
    }

    address public owner;
    mapping(uint => Candidate) public candidates;
    uint public candidateCount;

    mapping(address => bool) public hasVoted;

    // Event emitted when new candidate is added
    event CandidateAdded(uint id, string name);

    // Event emitted when a vote is cast
    event VoteCast(address voter, uint candidateId);

    // Initializes the contract, setting deployer as owner
    constructor() {
        owner = msg.sender;
    }

    // Adds a new candidate (only callable by contract owner)
    function addCandidate(string memory _name) public {
        require(msg.sender == owner, "Only owner can add candidates");
        candidates[candidateCount] = Candidate(_name, 0);
        emit CandidateAdded(candidateCount, _name);
        candidateCount++;
    }

    // Allows a voter to cast their vote (can only vote once)
    function vote(uint _candidateId) public {
        require(!hasVoted[msg.sender], "You have already voted");
        require(_candidateId < candidateCount, "Invalid candidate");

        candidates[_candidateId].voteCount++;
        hasVoted[msg.sender] = true;

        emit VoteCast(msg.sender, _candidateId);
    }

    // Returns candidate's name and total votes received
    function getCandidate(uint _candidateId) public view returns (string memory, uint) {
        Candidate memory c = candidates[_candidateId];
        return (c.name, c.voteCount);
    }
}
