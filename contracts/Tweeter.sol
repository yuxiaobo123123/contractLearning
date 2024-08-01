

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Tweeter{

    mapping (address => string[]) public  tweeter;

    function createTweet(string memory tweet) public {
        tweeter[msg.sender].push(tweet);
    }

    function getLatestTweet() public view returns(string memory){
        return tweeter[msg.sender][ tweeter[msg.sender].length - 1];
    }

}