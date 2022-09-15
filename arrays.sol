

pragma solidity 0.8.15;

contract Demo {

    bytes32 public myVar = "test";
    bytes public myVAr1 = "test";

    function demo() public view returns (uint) {
        return myVAr1.length;
    }
    // 1 --> 32
    // 32 --> 256

    // uint[3][2] public items;


    // function demo() public{
    //     items = [
    //         [3,5,5],
    //         [6,7,8]
    //     ];
       

    // }

    // uint[] public items ;
    // uint public len;
    // function demo() public {
    //     items.push(4);
    //     items.push(5);
    //     len = items.length;
    // }

    function sampleMemory() public view returns(uint[] memory) {
        uint[] memory tempArray = new uint[](10);
        tempArray[0] = 1;
        tempArray[1] = 2;
        tempArray[4] = 9;
        return tempArray;
    }


    //enum
    enum Status {
        Paid, Delivered,Received
    }
    Status public currentStatus;

    function pay() public {
        currentStatus = Status.Paid;
    }

    function  delivered() public {
        currentStatus = Status.Delivered;
    }
}