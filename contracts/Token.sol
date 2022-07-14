// SPDX License Identifier : MIT
pragma solidity >= 0.5.0 < 0.9.0;

contract Token {
    string public name =  "My Token";
    string public symbol  = "MT";
    uint256 public totalSupply = 10000;

    address public owner;
    mapping (address => uint256) balances;
     
     constructor () {
        balances[msg.sender] = totalSupply;
        owner = msg.sender;
     }
     //modifier
     modifier onlyOwner(){
        require(owner==msg.sender, "you're not owner");
        _;
     }

     //function to transfer 
     function transfer(address to , uint256 amount) external onlyOwner{
        require(balances[msg.sender]>=amount ,"not enough tokens");
        balances[msg.sender] -=amount;
        balances[to] +=amount;
     }
    // function to get balance of
     function balanceOf(address account) external onlyOwner view returns(uint){
        return balances[account];
     }
}