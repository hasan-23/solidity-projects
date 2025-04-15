// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SafeStore {
    mapping(address => uint) public stored;

    // ✅ Event
    event FavoriteNumberStored(address indexed user, uint newValue);

    function store(uint _value) public {
        require(_value >= 10, "Value must be at least 10");
        stored[msg.sender] = _value;

        // ✅ Emit the event
        emit FavoriteNumberStored(msg.sender, _value);
    }

    function get() public view returns (uint) {
        return stored[msg.sender];
    }
}
