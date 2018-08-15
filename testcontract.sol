pragma solidity ^0.4.0;

interface Regulator {
     function loan() returns(bool);
     function CheckValue(uint amount) returns(bool);
 }


contract Bank {
    uint private value;
    address private owner;
    
    // Error handling. Every function with this will only be useable by the owner
    modifier ownerFunc{
        require(owner == msg.sender);
        _;
    }
    
    function Bank(uint amount) {
        value = amount;
        owner = msg.sender;
    }
    
    function deposit(uint amount) ownerFunc {
        value += amount;
    }
    
    function withdraw(uint amount) ownerFunc {
        if (CheckValue(amount)){
            value -= amount;
        }
    }
    
    function balance() returns(uint) {
        return value;
    }
    function loan() returns(bool){
        return value > 0;
    }
    function CheckValue(uint amount) returns(bool){
        return value>=amount;
    }
}

contract MyContract is Bank {
    string private name;
    uint private age;
    
    function setName(string _name){
        name = _name;
    }
    
    function getName() returns(string) {
        return name;
    }
    
    function setAge(uint _age){
        age = _age;
    }
    
    function getAge() returns(uint) {
        return age;
    }
    
    function loan() returns(bool){
        return true;
    }
}

contract TestingThrows {
    function testRequire(){
     require(1==2);   
    }
        // penalizes through gas price and deducts it. Useful for retricting access
        // to private or internals
    function testAssert(){
        assert(false);
    }
    
    function testRevert(){
        // reverts gas price usage
        revert();
    }
    // consumes all the gas
    function testThrow(){
        throw;
    }
}


