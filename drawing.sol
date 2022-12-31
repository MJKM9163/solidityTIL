// SPDX-License-Identifier: GLP-3.0
pragma solidity >0.7.0 <0.9.0;

contract drawing {
    address public onwer;
    constructor () {
        onwer = msg.sender;
    }
    uint[] public position = [1, 1];
    uint[][] public maps = [
        [0,0,0],
        [0,0,0],
        [0,0,0]
    ];

    event info(string text);

    function itemPush(uint _x, uint _y) public {
        require(msg.sender == onwer ,"your is not onwer");
        if (maps[_x][_y] != 1) {
            maps[_x][_y] = 1;
        } else {
            revert("It already exists.");
        }
    }

    function moveUp() public {
        if (position[1] != 0) {
            position[1] -= 1;
        } else {
            revert("can't move anymore.");
        }
    }

    function moveRight() public {
        if (position[0] != maps[0].length-1) {
            position[0] += 1;
        } else {
            revert("can't move anymore.");
        }
    }

    function moveDown() public {
        if (position[1] != maps.length-1) {
            position[1] += 1;
        } else {
            revert("can't move anymore.");
        }
    }

    function moveLeft() public {
        if (position[0] != 0) {
            position[0] -= 1;
        } else {
            revert("can't move anymore.");
        }
    }

    function catchs() public {
        if (maps[position[0]][position[1]] == 1) {
            maps[position[0]][position[1]] == 0;
            emit info("success");
        } else {
            revert("there's nothing.");
        }
    }
}