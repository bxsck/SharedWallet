pragma solidity ^0.5.13;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract SimpleWallet is Ownable {
    
    function () external payable{
        
    }
    
    function withdrawMoney(address payable _to, uint _amount) public onlyOwner{
        
        _to.transfer(_amount);
    }
}