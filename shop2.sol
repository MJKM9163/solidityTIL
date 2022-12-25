// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <=0.9.0;

contract Test {

    enum shopStatus {
        open,
        close
    }
    shopStatus currentShop;

    enum items {
        plusItem,
        subtractItem
    }

    struct userStatus {
        items[] buyList;
    }

    address public onwer;
    mapping(address => userStatus) internal userData;

    constructor () {
        onwer = msg.sender;
        currentShop = shopStatus.close;
    }

    function shopControl () public {
        require(onwer == msg.sender, "your is not onwer");
        if (currentShop == shopStatus.close) {
            currentShop = shopStatus.open;
        } else {
            currentShop = shopStatus.close;
        }
    }

    function bayPlusItem () public {
        userData[msg.sender].buyList.push(items.plusItem);
    }

    function baySubtractItem () public {
        userData[msg.sender].buyList.push(items.subtractItem);
    }

    function plusItem (uint _num1, uint _num2) public view returns(uint result) {
        require(userData[msg.sender].buyList.length > 0 && currentShop == shopStatus.open, "not plusItem");
        bool check = false;
        for (uint i = 0; i < userData[msg.sender].buyList.length; i++) {
            if (userData[msg.sender].buyList[i] == items.plusItem) {
                check = true;
                break;
            }
        }
        if (check) {
            result = _num1 + _num2;
        } else {
            revert("not plusItem");
        }
    }

    function subtractItem (uint _num1, uint _num2) public view returns(uint result) {
        require(userData[msg.sender].buyList.length > 0 && currentShop == shopStatus.open, "not subtractItem");
        bool check = false;
        for (uint i = 0; i < userData[msg.sender].buyList.length; i++) {
            if (userData[msg.sender].buyList[i] == items.subtractItem) {
                check = true;
                break;
            }
        }
        if (check) {
            result = _num1 - _num2;
        } else {
            revert("not subtractItem");
        }
    }
}