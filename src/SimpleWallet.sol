pragma solidity ^0.5.13;

contract SimpleWallet {
    
    address public owner;
    
    constructor() public{
        owner = msg.sender;
    }
    
    function () external payable{
        
    }
    
    function withdrawMoney(address payable _to, uint _amount) public{
        require(owner == msg.sender, "You are not allowed");
        _to.transfer(_amount);
    }
}