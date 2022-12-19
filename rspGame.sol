// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Test {
    struct Player {
        string weapon;
        uint winCount;
    }

    mapping (address => Player) public players;
    event gameResult (string myWeapon, string opponentWeapon, string state);

    function weaponSelect (string memory weapon_) public {
        players[msg.sender].weapon = weapon_;
    }

    function gameStart (address opponent) public {
        require(opponent != address(0), "lack of players");
        string memory state_;
        Player storage myWeapon_ = players[msg.sender];
        Player storage opponentWeapon_ = players[opponent];

        if (keccak256(bytes(myWeapon_.weapon)) == keccak256(bytes(opponentWeapon_.weapon))) {
            state_ = "draw";
        } else if (keccak256(bytes(myWeapon_.weapon)) == keccak256(bytes("rock"))) {
            if (keccak256(bytes(opponentWeapon_.weapon)) == keccak256(bytes("scissors"))) {
                myWeapon_.winCount += 1;
                state_ = "win";
            } else if (keccak256(bytes(opponentWeapon_.weapon)) == keccak256(bytes("paper"))) {
                opponentWeapon_.winCount += 1;
                state_ = "lose";
            }
        } else if (keccak256(bytes(myWeapon_.weapon)) == keccak256(bytes("paper"))) {
            if (keccak256(bytes(opponentWeapon_.weapon)) == keccak256(bytes("rock"))) {
                myWeapon_.winCount += 1;
                state_ = "win";
            } else if (keccak256(bytes(opponentWeapon_.weapon)) == keccak256(bytes("scissors"))) {
                opponentWeapon_.winCount += 1;
                state_ = "lose";
            }
        } else if (keccak256(bytes(myWeapon_.weapon)) == keccak256(bytes("scissors"))) {
            if (keccak256(bytes(opponentWeapon_.weapon)) == keccak256(bytes("rock"))) {
                myWeapon_.winCount += 1;
                state_ = "win";
            } else if (keccak256(bytes(opponentWeapon_.weapon)) == keccak256(bytes("paper"))) {
                opponentWeapon_.winCount += 1;
                state_ = "lose";
            }
        }
        emit gameResult (myWeapon_.weapon, opponentWeapon_.weapon, state_);
        myWeapon_.weapon = "";
        opponentWeapon_.weapon = "";
    }
}