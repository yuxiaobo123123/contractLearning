

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MutipulGame{

    mapping (address => bool) public users;

    function joinGame() public virtual {
        users[msg.sender] = true;
    }

}

contract Game is MutipulGame{
    mapping (address => string) public info;

     function joinGame() public  override {
        super.joinGame();
    }
     function palyGame() public {

    }
     function exitGame() public {

    }
}
