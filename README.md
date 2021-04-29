# twitter_clone

This is a simple CRUD web app inspired by Twitter.

The intent of this repo is to show simple components for building a backend API that you cna use to get started with the IC.

There are two ways to interact with this backend canister:

a. Sending it messages via the DFX commandline
b. Attaching a web app which sends the backend canister messages using JavaScript

# Methods the Backend has

## 1. Get the tweets (akin to GET /tweets/ )
- Shows all of the logged in user's most recent tweets

`public query func get_tweets() : async Text { };`

## 2. Post a tweet (akin to POST /tweets/ )
- Creates a new post as the logged in user

`public func create_tweets(tweet: Text)  : async Text { }`

## 3. Get the feed of tweets (akin to GET /tweets/feed )
- Shows the most recent tweets by user's the logged in user is following

## 4. Get the tweets of a user (akin to GET /tweets/:userId )
- see tweets by a particular user

## 5. Follow a user
- Allows the authenticated user to follow another user on the platform