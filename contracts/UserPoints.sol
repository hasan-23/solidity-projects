// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserPoints {
    mapping(address => uint) public points;

    event PointsUpdated(address indexed user, uint newPoints);

    function addPoints(uint p) public {
        points[msg.sender] += p;
        emit PointsUpdated(msg.sender, points[msg.sender]);
    }

    function reset() public {
        points[msg.sender] = 0;
        emit PointsUpdated(msg.sender, 0);
    }

    function getPoints() public view returns (uint) {
        return points[msg.sender];
    }
}
