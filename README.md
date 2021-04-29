# twitter_clone

This is a simple CRUD web app inspired by Twitter.

The intent of this repo is to show simple components for building a backend API that you cna use to get started with the IC.

# Methods the Backend has

## Get the tweets (akin to GET /tweets/)
//Shows all of the logged in user's most recent tweets
public query func get_tweets() : async Text { }; 

## Post a tweet (akin to POST /tweets/ )
//Creates a new post as the logged in user
public func create_tweets(tweet: Text)  : async Text { }

## Get the feed of tweets (akin to GET /tweets/feed )
//Shows the most recent tweets by user's the logged in user is following

## Get the tweets of a user (akin to GET /tweets/:userId)
//see tweets by a particular user

## Follow a user
//Allows the authenticated user to follow another user on the platform