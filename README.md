# Building a simple backend canister Tutorial

This is a simple CRUD web app inspired by Twitter.

The intent of this repo is to show simple components for building a backend API that you can use to get started with the Internet Computer.

There are two ways to interact with this backend canister:

a. Sending it messages via the DFX command line tool

b. Attaching a web app which sends the backend canister messages using JavaScript

# The goal and intent

The goal and intent of this app is to take someone who has never deployed to the Internet Computer or used Motoko and walk through the basics. It is deliberately simplistic and tries to explain many steps which more experienced engineers may find verbose.

## Things you will learn with this tutorial:
- Basics of Motoko
- How to make a Key Value Store
- How to call your backend via DFX

## Main resources you will need

https://sdk.dfinity.org/docs/language-guide/

# Methods the Backend has

## 1. Get the tweets (akin to GET /tweets/ )
- Shows all of the logged in user's most recent tweets

`public query func get_tweets() : async [Tweet] {}`

## 2. Post a tweet (akin to POST /tweets/ )
- Creates a new post as the logged in user

`public func create_tweet(post: Tweet)  : async Bool { }`

## 3. Get the feed of tweets (akin to GET /tweets/feed )
- Shows the most recent tweets by user's the logged in user is following

`public query shared(msg) func get_feed() : async [Tweet]{}s`

## 4. Get the tweets of a user (akin to GET /tweets/:userId )
- see tweets by a particular user
`public func get_tweet(userid: Text) : async [Tweet] {}`

## 5. Follow a user
- Allows the authenticated user to follow another user on the platform
`public follow_user(userId: Text) : async Bool`