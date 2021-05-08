pragma solidity ^0.5.13;

contract SimpleWallet {
    
    function () external payable{
        
    }
    
    function withdrawMoney(address payble _to, uint _amout) public{
        _to.transfer(_amount);
    }
}