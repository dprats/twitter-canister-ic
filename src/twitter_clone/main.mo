//0. LIBRARIES 
import Array "mo:base/Array";
import Nat "mo:base/Nat";
import H "mo:base/HashMap";

actor {

    //1. TYPES
    //Declare the types we willl use for this simple twitter clone. This akin to the data schema
    //You do NOT need to have custom record types to build a simple app, but I find it helps simplify

    //1.1 The User type
    type User = {
        username: Text;
        followers: [User];  //array of users
        tweets: [Tweet]; //array of tweets
    }; 
    
     //1.2 The Tweet Type
    type Tweet = {
        user : User; //User type defined in 1.1
        copy : Text;
    }; 


    //2. THE STATE
    //This is where we store the users and the tweets.
    // We will use a simple key value store where... 
    // a. Key: is a Principal.  
    // b. Value: the User record type defined in 1.1


    //To construct this key-value store, we need to understand two:
    
    // a. Principal: This is a primitive we will use to identiy users. The principal associated with a call is a value that identifies a unique user".
    //         You can fead more here: https://sdk.dfinity.org/docs/language-guide/caller-id.html
    
    // b. HashMap: There are many ways to build a key-value store, and we will use the HashMap for 
    //         this example. You can read more here: https://sdk.dfinity.org/docs/base-libraries/hashmap

        // 2.1 The users of the platform
        var user1: Text = "Diego";

        var user2 : User = {
            username = "dprats";
            followers = [];
            tweets = [Tweet];
        };

         var user3 : User = {
            username = "yanChen";
            followers = [user2];
        };

    
        let tweets : [Tweet] = [
            {"Diego", "First"},
            {"Diego", "Second"},
            {"Jordi", "Hola!"},
        ];

        //SCRATCHPAD

        //key value store
        let store: HashMap<Text, Text> = {
            "Dprats": "Diego"
        };

        let store = H.HashMap<Text, Buffer<Text>>(0, Text.equal, Text.hash);



        let buffer1 = Buffer(0);
        buffer1.put("First");
        buffer1.put("second");


        store.put("dprats", buffer1);
        store.get("dprats"); // ["First", "Second"]);
        buffer1.put("third");
        store.get("dprats"); // ["First", "Second", "third"]);

        let  = H.HashMap<Principal, User>;


        "fd[pdmdpindobd33": {
            user: user1
        }
        


    //3. PUBLIC METHODS
    //Public Methods (akin to "API endpoints") this backend canister will expose to the world.

        //3.0 "What is my name?" method returns the user info
        public query func read() : async Text {
            return user1;
        }; 

        //3.1 Get the tweets (akin to GET /tweets/)
        //Shows all of the logged in user's most recent tweets
        public query func get_tweets() : async [Tweet] {
            return tweets;
        }; 

        //3.2 Post a tweet (akin to POST /tweets/ )
        //Creates a new post as the logged in user
        public func create_tweet(post: Tweet)  : async Bool {
            return true;
        }

        //3.3 Get the feed of tweets (akin to GET /tweets/feed )
        //for a logged in user, construct a feed of all tweets they should see
        public query shared(msg) func get_feed() : async [Tweet]{
            let user = msg.caller; // this is a principal ID
        }

        //3.4 Get the tweets of a user (akin to GET /tweets/:userId)
        //see tweets by a particular user
        public func get_tweet(userid: Text) : async [Tweet] {
            []
        }
        //3.5 Follow a user
        //Allows the authenticated user to follow another user on the platform
        public follow_user(userId: Text) : async Bool {
            return true;
        }

    //4. Utility or "helper" methods that the canister uses in its function. 
    //These are all private and not visible to the world.

    //hello world 
    public func greet(name : Text) : async Text {
        return "Hello, " # name # "!";
    };


};
