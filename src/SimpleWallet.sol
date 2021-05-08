pragma solidity ^0.5.13;

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Ownable{
    address public owner;
    
    constructor() public{
        owner = msg.sender;
    }
    modifier onlyOwner(){
        require(owner == msg.sender,"You are not allowed.");
        _;
    }
}
contract Allowance is Ownable{
    event AllowanceChanged(address indexed _forWho, address indexed _fromWhom, uint _oldAmount, uint _newAmount);
    mapping(address => uint) public allowance;
    
    function addAllowance(address _who,uint _amount) public onlyOwner{
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    }
    
    modifier ownerOrAllowed(uint _amount){
        require(owner==msg.sender || allowance[msg.sender] >= _amount, "You are not allowed");
        _;
    }
   
   function reduceAllowance(address _who, uint _amount) internal{
       emit AllowanceChanged(_who, msg.sender, allowance[_who], allowance[_who]-_amount);
       allowance[_who] -= _amount;
   }
}
contract SimpleWallet is Allowance{
    
    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);
    function withdrawMoney(address payable _to, uint _amount) public onlyOwner{
        require(_amount <= address(this).balance,"There are not enough funds stored in the smart contracts");
        if(owner!=msg.sender){
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }
    
    function renounceOwnership() public onlyOwner{
        revert("Can't renounce ownership here");
    }
    
     function () external payable{
         emit MoneyReceived(msg.sender, msg.value);
        
    }
    
}