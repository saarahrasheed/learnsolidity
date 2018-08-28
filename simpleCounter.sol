pragma solidity 0.4.24;

contract SimpleCounter {
    int256 counter; // state variable
    address owner;
    string description = 'This is a simple counter';
    
    constructor() public {
        counter = 0;
        owner = msg.sender;
    }

    function getCounter() view public returns(int) {
        return counter;
    }
    function increment() payable public {
        // require(msg.value > 0.1 ether); 
        counter +=1;
    }
    function decrement() public {
        counter -=1;
    }
    
    function reset() public {
        require(msg.sender == owner);
        counter = 0;
    }
}
