

// SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/access/Ownable.sol";


pragma solidity ^0.8.0;


interface IProfile {

   struct UserProfile {
        string displayName;
        string bio;
    }

    function setProfile(string memory displayName, string memory bio) external;
    function getProfile(address _user) external view returns (UserProfile memory);
    
}

contract Twitter is Ownable{

    uint16 public MAX_TWEET_LENGTH = 255;

    //defined struct 
    struct Tweet{
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }


    mapping (address => Tweet[]) public tweets;

    IProfile profileContarct;

    event TweetCreated(uint256 id, address auther, string content, uint256 timestamp);
    event TweetLiked(address liker,address tweetAuthor,uint256 tweetId,uint newLikeCount);
    event TweetUnliked(address unliker,address tweetAuthor,uint256 tweetId,uint newLikeCount);

    modifier onlyRegistered(){
        IProfile.UserProfile memory userProfileTemp = profileContarct.getProfile(msg.sender);
        require(bytes(userProfileTemp.displayName).length > 0,"USER NOT REGISTED");
        _;
    }


    constructor(address _profileContract) Ownable(msg.sender) {
        profileContarct = IProfile(_profileContract);
    }

    function changeTweetLength(uint16 newTweetLength) public onlyOwner{
        MAX_TWEET_LENGTH = newTweetLength;
    }

    function getTotalLikes(address _author) external view returns(uint){

        uint totalLikes;
        for(uint i = 0; i< tweets[_author].length;i++){
            totalLikes+=  tweets[_author][i].likes;
        }
        return totalLikes;

    }

    function createTweet(string memory _tweet) public onlyRegistered {

        require(bytes(_tweet).length<=MAX_TWEET_LENGTH,"Your tweet is too long bro");

        Tweet memory newTweet = Tweet({
                id:tweets[msg.sender].length,
                author: msg.sender,
                content:_tweet,
                timestamp:block.timestamp,
                likes:0
        });
        tweets[msg.sender].push(newTweet);

        emit TweetCreated(newTweet.id,newTweet.author,newTweet.content,newTweet.timestamp);
    }

    function likeTweet(address author,uint256 id) external {
        require(tweets[author][id].id==id,"TWEET DOSE NOT EXIST");
        tweets[author][id].likes++;
        emit TweetLiked(msg.sender,author,id,tweets[author][id].likes);
    }
    function unLikeTweet(address author,uint256 id) external  {
        require(tweets[author][id].id==id,"TWEET DOSE NOT EXIST");
        require(tweets[author][id].likes>0,"TWEET HAS NO LIKES");
        tweets[author][id].likes--;

        emit TweetUnliked(msg.sender,author,id,tweets[author][id].likes);
    }

    function getTweet(uint _i) public view returns (Tweet memory) {
        return tweets[msg.sender][_i];
    }

    function getAllTweets(address _owner) public view returns(Tweet[] memory){

        return tweets[_owner];
    }

}
