pragma solidity ^0.5.13;

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract SimpleWallet{
    address public owner;
    
    constructor() public{
        owner = msg.sender;
    }
    modifier onlyOwner(){
        require(owner == msg.sender,"You are not allowed.");
        _;
    }
    
    mapping(address => uint) public allowance;
    
    function addAllowance(address _who,uint _amount) public onlyOwner{
        allowance[_who] = _amount;
    }
    
    modifier ownerOrAllowed(uint _amount){
        require(owner==msg.sender || allowance[msg.sender] >= _amount, "You are not allowed");
        _;
    }
   
    function withdrawMoney(address payable _to, uint _amount) public onlyOwner{
        _to.transfer(_amount);
    }
    
     function () external payable{
        
    }
    
}