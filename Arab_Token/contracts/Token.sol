// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";


contract token{
 using SafeMath for uint;
string public name = "Arabic Token";
string public symbol = "ARAB";
uint256 public decimals = 10;
uint256 public totalSupply;

mapping(address=>uint256) public balanceOf;
event Transfer(address indexed _from, address indexed _to, uint256 _value);

    constructor() {
    totalSupply = 2000 * (10 ** decimals); //2000,00000,00000
    balanceOf[msg.sender]= totalSupply;
    }

function transfare(address _to,uint256 _value) public returns(bool success){

    require(_to != address(0)); //0x0
    require(balanceOf[msg.sender] >= _value);

    balanceOf[msg.sender] = balanceOf[msg.sender].sub(_value);
    balanceOf[_to] =balanceOf[_to].add(_value);
    emit Transfer(msg.sender,_to,_value);
    


    return true;

}

modifier save(){
require(msg.value != 0);

_;
}



}