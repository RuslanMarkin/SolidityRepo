pragma solidity 0.8.15;

contract Demo {


    mapping (address => uint) public payments;

    address public myAddr =  0x5B38Da6a701c568545dCfcB03FcB875f56beddC4; 


    function receiveFunds() public payable {
        payments[msg.sender] = msg.value; 
        
    }

    function transferTo ( address targetAddr, uint amount) public {
        address payable _to = payable(targetAddr);
        _to.transfer(amount);
    }



    function getBalace(address targetAddr) public view returns(uint) {
       return targetAddr.balance; 
    }

    string public myStr = "Test";

    function demo(string memory newValueStr) public {
        //string memory myTempStr = "temp"; 
        myStr = newValueStr ;
    }
    