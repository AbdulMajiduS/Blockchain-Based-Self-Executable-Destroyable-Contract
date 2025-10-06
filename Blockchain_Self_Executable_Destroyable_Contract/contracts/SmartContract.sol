// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
 * Blockchain-Based Self-Executable & Destroyable Contract
 * Developed by Abdul Majidu for Smart India Hackathon
*/

contract SelfExecutableContract {
    address public owner;
    uint256 public amount;
    bool public executed;

    event Executed(address indexed executor, uint256 value);
    event Destroyed(address indexed by);

    constructor(uint256 _amount) payable {
        owner = msg.sender;
        amount = _amount;
        executed = false;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized!");
        _;
    }

    // Function that executes automatically once balance condition is met
    function execute() public {
        require(address(this).balance >= amount, "Insufficient balance");
        require(!executed, "Already executed");

        executed = true;
        emit Executed(msg.sender, address(this).balance);
    }

    // Function to self-destruct after execution
    function destroyContract() public onlyOwner {
        require(executed, "Execute first before destruction");
        emit Destroyed(msg.sender);
        selfdestruct(payable(owner));
    }

    // Receive Ether
    receive() external payable {}
}
