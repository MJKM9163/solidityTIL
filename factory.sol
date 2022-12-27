// SPDX-License-Identifier: GLP-3.0
pragma solidity >0.7.0 <0.9.0;

interface ItemFrame {
    enum typeName {
        electronic,
        food,
        toy
    }

    struct item {
        uint price;
        string name;
        typeName itemType;
    }

    function makeItem (uint _price, string memory _name) external;
    function getItem () external returns(item[] memory);
}

contract electronicFactory is ItemFrame {
    typeName types;
    constructor () {
        types = typeName.electronic;
    }
    item[] public items;
    event makeCheck (item state);

    function makeItem (uint _price, string memory _name) override public {
        items.push(item(_price, _name, types));
        emit makeCheck (items[items.length - 1]);
    }
    function getItem () override public view returns(item[] memory) {
        item[] memory arr = new item[](items.length);
        for (uint i = 0; i < items.length; i++) {
            if (items[i].itemType == types) {
                arr[i] = items[i];
            } else {
                i -= 1;
            }
        }
        return arr;
    }
}