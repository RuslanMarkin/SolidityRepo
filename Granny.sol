//SPDX-License-Identifier: MIT


pragma solidity 0.8.15;

contract Granny {
    uint8 public counter;

    uint256 public bank;

    address public owner;

    struct Grandchild {
        string name;
        uint256 birthday; 
        bool alreadyGotMoney;
        bool exist; 
    }

    address[] public arrGrandChilds;

    mapping(address => Grandchild) public grandchilds;

    constructor() {
        owner = msg.sender;
        counter = 0;
    }

     function addGrandChild(
        address walletAddress,
        string memory name,
        uint256 birthday
    ) public onlyOwner {
        require(birthday > 0, "Something is wrong with the date of birth!");

        require(
            grandchilds[walletAddress].exist == false,
            "There is already such a grandchild!"
        );
        grandchilds[walletAddress] = (
            Grandchild(name, birthday, false, true)
        );
        arrGrandChilds.push(walletAddress);
        counter++;
        emit NewGrandChild(walletAddress, name, birthday);
    }



    function withdraw() public {
        address payable walletAddress = payable(msg.sender);

        require(
            grandchilds[walletAddress].exist == true,
            "Error! There is no such grandchild"
        );
        require(
            block.timestamp > grandchilds[walletAddress].birthday, 
            "Too early for You,Son"
        );
        require(
            grandchilds[walletAddress].alreadyGotMoney == false, 
            "You have already receive money"
        );

        uint256 amount = bank / counter ; 
        grandchilds[walletAddress].alreadyGotMoney = true; 

        (bool success, ) = walletAddress.call{value: amount}("");
        require(success);

        emit gotMoney(walletAddress);


    }



    function readGrannyChildsArray(uint cursor, uint length) public view returns (address[] memory) {
        address[] memory array = new address[](length); 
        uint counter2 = 0; 
        for (uint i = cursor; i < cursor+length; i++) {
            array[counter2] = arrGrandChilds[i];
            counter2++;
        }
        return array;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not owner");
        _;
    }



    function balanceOf() public view returns (uint256) {
        return address(this).balance;
    }

    receive() external payable {
        bank += msg.value;
    }

    event NewGrandChild(address indexed walletAddress, string name, uint256 birthday);
    event gotMoney(address indexed walletAddress); 

}