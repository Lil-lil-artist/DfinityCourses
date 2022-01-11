import List "mo:base/List";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";
import D "mo:base/Debug";
import Time "mo:base/Time";
import Int = "mo:base/Int";
  /// import Time = "mo:base/Time";
  ///
  /// actor {
  ///   
  /// };

actor {
    var lastTime = Time.now();
    //D.print(debug_show(lastTime));
    public func greet(name : Text) : async Text {
       let now = Time.now();
       //D.print(Int.toText(now));
       let elapsedSeconds = (now - lastTime) / 1000_000_000;
       lastTime := now;
       
       
       return "Hello, " # name # "!" #
         " I was last called " # Int.toText(elapsedSeconds) # " seconds ago";
    
    };
    public type Message = 
    {
        text : Text;
        time : Time.Time;
    };
    
    public type Microblog = actor {
        follow: shared (Principal) -> async ();//关注新用户
        follows: shared query () -> async [Principal];//return followers list
        post: shared (Text) -> async ();//post new message 
        posts: shared query (Time.Time) -> async [Message];//return all message published
        timeline : shared (Time.Time) -> async [Message]; //return all meassage published by all followers
    };

    stable var followed : List.List<Principal> = List.nil(); //the list of people you followed

    public shared func follow(id: Principal) : async (){
        followed := List.push(id, followed);
    };

    public shared query func follows() : async [Principal] {
        List.toArray(followed)
    };

    stable var messages : List.List<Message> =List.nil();

    
    public shared (msg) func post(text: Text) : async (){
        //assert (Principal.toText(msg.caller)== "6fe5r-75tlg-i4t4q-zzr2y-hvi3m-jj76y-nqzti-xutid-3uttm-ldxv6-aae");
        var now = Time.now();
        var msg = {text=text;time=now};
        messages := List.push(msg, messages)
    };
       

    public shared query func posts (since: Time.Time) : async [Message]{
        
        var newmessages : List.List<Message> =List.nil();
        for (msg in Iter.fromArray(List.toArray(messages))){
            if(Int.greater(msg.time,since)){
                newmessages := List.push(msg,newmessages);
            };
        };
        List.toArray(newmessages)
    };
    
    public shared func timeline(since: Time.Time) : async [Message]{
        //create a empty list to store message
        var all : List.List<Message> = List.nil();
        for (id in Iter.fromList(followed)){
            let canister:Microblog = actor (Principal.toText(id));           
            let msgs = await canister.posts(since);
           for (msg in Iter.fromArray(msgs)){
               all := List.push(msg, all);           
           }
        };
        List.toArray(all)
    };
};
