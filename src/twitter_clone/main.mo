actor {

    //0. LIBRARIES 
    import Array "mo:base/Array";
    import Nat "mo:base/Nat";

    //1. TYPES
    //Declare the types we willl use for this simple twitter clone. This akin to the schema

    // 1.2 The tweets of the platform
    public type Tweet = {
        user : Text;
        copy : Text;
    }; 


    //2. THE STATE
    //This is where we store the users and the tweets

        // 2.1 The users of the platform
        var user1: Text = "Diego";
    
        let tweets : [Tweet] = [
            {"Diego", "First"},
            {"Diego", "Second"},
            {"Jordi", "Hola!"},
        ];

    //3. PUBLIC METHODS
    //Public Methods (akin to "API endpoints") this backend canister will expose to the world.

        //3.0 "What is my name?" method returns the user info
        public query func read() : async Text {
            return user1;
        }; 

        //3.1 Get the tweets (akin to GET /tweets/)
        //Shows all of the logged in user's most recent tweets
        public query func get_tweets() : async Text {
            return tweets;
        }; 

        //3.2 Post a tweet (akin to POST /tweets/ )
        //Creates a new post as the logged in user
        public func create_tweets(tweet: Text)  : async Text {
            return tweet;
        }

        //3.3 Get the feed of tweets (akin to GET /tweets/feed )
        //Shows the most recent tweets by user's the logged in user is following

        //3.4 Get the tweets of a user (akin to GET /tweets/:userId)
        //see tweets by a particular user

        //3.5 Follow a user
        //Allows the authenticated user to follow another user on the platform

    //4. Utility or "helper" methods that the canister uses in its function. 
    //These are all private and not visible to the world.

    //hello world 
    public func greet(name : Text) : async Text {
        return "Hello, " # name # "!";
    };


};
