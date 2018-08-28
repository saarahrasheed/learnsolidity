pragma solidity ^0.4.24;

contract Escrow{
    
    enum State {AWAITING_PAYMENT, AWAITING_DELIVERY, COMPLETE, REFUNDED}
    State public currentState; //The currentState is initialized with the first value of State
    
    address public buyer;
    address public seller;
    address public orbiter;
    
    modifier buyerOnly(){
        require(msg.sender == buyer || msg.sender == orbiter);
        _;
    }
    
    modifier sellerOnly(){
        require(msg.sender == seller || msg.sender == orbiter);
        _;
    }
    
    modifier inState(State expectedState){
        require(currentState == expectedState);
    }
    
    function Escrow(address _buyer, address _seller, address _orbiter){
        buyer = _buyer;
        seller = _seller;
        orbiter = _orbiter;
    }
    function confirmPayment() buyerOnly inState(State.AWAITING_PAYMENT) payable{
        currentState = State.AWAITING_DELIVERY;
    }
    function confirmDelivery() buyerOnly inState(State.AWAITING_DELIVERY){
        seller.send(this.balance);
        currentState = State.COMPLETE;
    }
    function refundBuyer() sellerOnly inState(State.AWAITING_DELIVERY){
        buyer.send(this.balance);
        currentState = State.REFUNDED;
    }
    
    
}

