//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Greeter {
    uint256 private balance;
    address private admin;

    constructor() {
        admin = msg.sender;
        console.log("Admin address has been set to %s", msg.sender);
    }

    // get the contract address
    function getAddress() public view returns (address) {
        return address(this);
    }

    // function getCustomerBalance() external view returns (uint256) {
    function getBalance() public view returns (uint256) {
        require(
            msg.sender == admin,
            "Only the address that deployed this contract can see it's balance."
        );
        return address(this).balance;
    }

    // get the eth balance of the address passed as an argument
    function getUserBalance(address _addr) public view returns(uint256) {
        // addr.balance = eth balance of the address passed as on argument
        // msg.sender.balance = eth balance of the address that is calling this argument
        console.log("_addr.balance: %s ... msg.sender.balance: %s", _addr.balance, msg.sender.balance);
        return _addr.balance;
    }

    function depositMoney() public payable {
        require(msg.value != 0, "You need to deposit some amount of money!");
        balance += msg.value;
        // msg.value contains the amount of wei (ether / 1e18) sent in the transaction.
    }

    function withdrawMoney(address payable _to, uint256 _amount) public payable {
        require(
            _amount <= address(this).balance,
            "You have insuffient funds to withdraw"
        );
        require(
            msg.sender == admin,
            "Only the address that deployed this contract will be able to withdraw from it."
        );
        balance -= _amount;
        _to.transfer(_amount);
    }


// Account #19: 0x8626f6940e2eb28930efb4cef49b2d1f2c9c1199 (10000 ETH)
// Private Key: 0xdf57089febbacf7ba0bc227dafbffa9fc08a93fdc68e1e42411a14efcf23656e
}