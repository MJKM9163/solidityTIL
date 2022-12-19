// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;

contract Shop {
    struct ItemState {
        string name;
        uint price;
    }

    struct UserState {
        uint money;
        string[] itemList;
    }

    address public owner;
    ItemState[] public salesList;
    mapping (address => UserState) public userList;

    constructor () {
        owner = msg.sender;
    }

    function itemRegist (string memory itemName, uint itemPrice) public {
        require(msg.sender == owner, "not is owner");
        salesList.push(ItemState(itemName, itemPrice));
    }

    function buy (uint itemIndex) public {
        uint itemPrice_ = salesList[itemIndex].price;
        UserState storage playerState = userList[msg.sender];
        if (itemPrice_ <= playerState.money) {
            playerState.money -= itemPrice_;
            playerState.itemList.push(salesList[itemIndex].name);
        } else {
            revert("you don't have enough money.");
        }
    }

    function testCode () public {
        UserState storage setUser = userList[msg.sender];
        setUser.money = 100;
    }

    function userInfo () public view returns (UserState memory) {
        return userList[msg.sender];
    }

}