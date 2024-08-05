

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Twitter{

    uint16 public MAX_TWEET_LENGTH = 255;

    //defined struct
    struct Tweet{
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }


    mapping (address => Tweet[]) public tweets;
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner,"YOU ARE NOT THE OWNER");
        _;
    }


    function changeTweetLength(uint16 newTweetLength) public onlyOwner{
        MAX_TWEET_LENGTH = newTweetLength;
    }

    function createTweet(string memory _tweet) public {

        require(bytes(_tweet).length<=MAX_TWEET_LENGTH,"Your tweet is too long bro");

        Tweet memory newTweet = Tweet({
                author: msg.sender,
                content:_tweet,
                timestamp:block.timestamp,
                likes:0
        });
        tweets[msg.sender].push(newTweet);
    }

    function getTweet(uint _i) public view returns (Tweet memory) {
        return tweets[msg.sender][_i];
    }

    function getAllTweets(address _owner) public view returns(Tweet[] memory){

        return tweets[_owner];
    }

}
