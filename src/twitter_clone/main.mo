//0. LIBRARIES 
import Array "mo:base/Array";
import Nat "mo:base/Nat";
import H "mo:base/HashMap";
import Buffer "mo:base/Buffer";
import Text "mo:base/Text";
import P "mo:base/Principal";


actor {

    //1. TYPES
    //Declare the types we willl use for this simple twitter clone. This akin to the data schema
    //You do NOT need to have custom record types to build a simple app, but I find it helps simplify

    //1.1 The User type
    type User = {
        username: Text;
        followers: [Text];  //array of usernames
    }; 
    
     //1.2 The Tweet Type
  


    //2. THE STATE
    //This is where we store the users and the tweets.
    // We will use two simple key value stores:
    // 1. Key Value store mapping principals to usernames
    // 2. Key value store mapping usernames to arrays of tweetss


    //To construct this key-value store, we need to understand two concepts:
    
    // a. Principal: This is an Internet Computer primitive we will use to identiy users. 
    //    The principal associated with a call is a value that identifies a unique user".
    //    You can read more here: https://sdk.dfinity.org/docs/language-guide/caller-id.html
    //    This is not Motoko-specific. Any language (e.g. Rust) which can deploy to IC has this type.
    //    Example of a Principal: "q6j5j-trrwk-h7td3-ktkjf-qcgim-n3pmz-jwycu-nhpau-6v66n-ctjzg-4qe"
    
    // b. HashMap: This is a Motoko-specific data structure. There are many ways to build a key-value store in the IC, 
    //    but these do depend on the Language you are using. For Motoko, there are a few options.
    //    For this tutorial, will use the HashMap data structure. You can read more here: https://sdk.dfinity.org/docs/base-libraries/hashmap

        //2.1 Username Data Store
        // Key value store where Principal is the key, username is the value
        // {
        //  ....
        //   "username1": [Tweet1, Twee2, etc...],
        //   "username2": [Tweet3, Twee4, etc...],
        //   ...
        //  }
        let username_store = H.HashMap<Principal, Text>(0, P.equal, P.hash);
        //2.2.1 seed the user store with initial data
        let userPrincipal1: Principal = P.fromText("q6j5j-trrwk-h7td3-ktkjf-qcgim-n3pmz-jwycu-nhpau-6v66n-ctjzg-4qe");
        let username1 = "dprats";
        username_store.put(userPrincipal1, username1);

        //2.1 s
       
        //2.2 Key value store where username is the key, array of tweets is the value
        // {
        //  ....
        //   "username1": [Tweet1, Twee2, etc...],
        //   "username2": [Tweet3, Twee4, etc...],
        //   ...
        //  }
        type Tweet = {
            copy : Text;
        }; 

        // Line 77 is worth breaking down... we got a lot going here....
        // a. H is the library imported in line 4
        // b. H.HashMap() is the library method to create a new hashmap: https://sdk.dfinity.org/docs/base-libraries/hashmap
        // c. H.HashMap< A, B> needs the type of the key and the type of the value
        // d. We want a MUTABLE list to store the growing list of Tweets. There are many ways to do this but we use a Buffer below.
        // e. If your first instinct was to use an Array for a growing list, note that Arrays are fixed-length lists in Motoko.
        let tweets_store = H.HashMap<Text, Buffer.Buffer<Tweet>>(0, Text.equal, Text.hash);

        //2.3.1 Seed initial data

        //seed the buffer of tweets
        let tweet1: Tweet = {
            copy = "this is my first tweet";
        };
        let tweet2: Tweet = {
            copy = "this is my second tweet";
        };
        let tweet_buffer = Buffer.Buffer<Tweet>(1); //
        tweet_buffer.add(tweet1);
        tweet_buffer.add(tweet2);

        //add the buffer of tweets to the data store (with right username as key)
        tweets_store.put(username1, tweet_buffer);


    //3. PUBLIC METHODS
    //Public Methods (akin to "API endpoints") this backend canister will expose to the world.

        //3.1 Get the tweets (akin to GET /tweets/)
        //Shows all of the logged in user's most recent tweets
        public shared(msg) func get_tweets() : async [Tweet] {
            
            // 3.1.1 get the caller's principal 
            let user_principal = msg.caller; 

            //3.1.2 using the principal, find the user's username
            // Note: the principal MAY not be in the store, .get()
            // may return nothing. In some languages, .get() would return NULL or NIL or FALSE.
            // Motoko (as Swift, Rust, Scala, etc...) returns an Optional type. 
            // "?Text" means "username" is an optional which MAY be a Text or nothing.
            // you use the option type with pattern matching to tell the program what to 
            //do in case the .get() finds nothing.
            // See pattern matching for more details: https://sdk.dfinity.org/docs/language-guide/pattern-matching.html
            let username : Text = switch(username_store.get(user_principal)){
                case null {
                    return []; //in case of nothing, return an empty list
                };
                case (?text) text; 
            };

            //3.1.3 using username, return array of tweets
            // This has same pattern as 3.1.2, we have to use pattern matching to tell the program
            // what to do in the case of both options (it wont compile otherwise!)
            let tweet_buffer : [Tweet] = switch(tweets_store.get(username)) {
                case null {
                    return []; //in case of of nothing, return empty "array". This should not happen if data is consistent across stores
                };
                case (?Buffer) Buffer<Tweet>;
            };

            
            return tweet_buffer.toArray();
        }; 

        //3.2 Post a tweet (akin to POST /tweets/ )
        //Creates a new post as the logged in user
        public shared(msg) func create_tweet(post: Tweet)  : async Bool {
           
            // 3.2.1 get the caller's principal 
            let user_principal = msg.caller; 

            //3.2.2 using the principal, find the user's username
            let username = username_store.get(user_principal);

            //3.2.3 using the username, add this tweet to the mutable buffer of tweets
            let tweet_buffer = tweets_store.get(username);
            let tweet: Tweet = {
                copy = post;
            };
            tweet_buffer.put(tweet);

            return true;
        };

        //3.3 Get the feed of twazeets (akin to GET /tweets/feed )
        //for a logged in user, construct a feed of all tweets they should see
        public shared(msg) func get_feed() : async [Tweet] {
            let user = msg.caller; // this is a principal ID
            return tweets;

        };

        //3.4 Get the tweets of a user (akin to GET /tweets/:userId)
        //see tweets by a particular user
        public func get_tweet(userid: Text) : async [Tweet] {
            return [];
        };

        //3.5 Follow a user
        //Allows the authenticated user to follow another user on the platform
        // public follow_user(userId: Text) : async Bool {
        //     return true;
        // };

    //4. Utility or "helper" methods that the canister uses in its function. 
    //These are all private and not visible to the world.s

};
