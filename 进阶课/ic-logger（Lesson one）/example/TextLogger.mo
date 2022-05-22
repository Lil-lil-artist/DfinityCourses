// Persistent logger keeping track of what is going on.

import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Deque "mo:base/Deque";
import List "mo:base/List";
import Nat "mo:base/Nat";
import Option "mo:base/Option";

import Logger "mo:ic-logger/Logger";

shared(msg) actor class TextLogger() {

  stable var state : Logger.State<Text> = Logger.new<Text>(0, null);
  let logger = Logger.Logger<Text>(state);
  
  // Add a set of messages to the log.
  public shared (msg) func append(msgs: [Text]) {
    logger.append(msgs);
  };

  // Return the messages between from and to indice (inclusive).
  public shared query (msg) func view(from: Nat, to: Nat) : async Logger.View<Text> {
    logger.view(from, to)
  };
  
  
  
  
  
  
  /*
  let OWNER = msg.caller;
  
  //create a new State
  stable var state : Logger.State<Text> = Logger.new<Text>(0, null);
  //create a new Logger actor with state
  let logger = Logger.Logger<Text>(state);

  //Deque : double-ended queues. https://smartcontracts.org/docs/current/references/motoko-ref/deque/
  //store States
  stable var states : Deque.Deque<Logger.State<Text>>;
  stable var num_of_states = 0 ;
  //the number of Text appended
  stable var NumberOfText = 0;
  ACTOR_SIZE = 100;

  // Principals that are allowed to log messages.
  stable var allowed : [Principal] = [OWNER];

  // Set allowed principals.
  public shared (msg) func allow(ids: [Principal]) {
    //assert(msg.caller == OWNER);
    allowed := ids;
  };

  
  //get owner
  public shared query (msg) func WhoIsOwner() : async Principal {
    //assert(msg.caller == OWNER);
    OWNER
  };

  // Move actor into actors
    public func roll_over_actors() {
      
      //buckets stores array, bucket is list
      states := Deque.pushBack(states, state);
      num_of_states := num_of_states + 1;
      
      //Create an empty actor.
      //create a new State
      state : Logger.State<Text> = Logger.new<Text>(0, null);
      //create a new Logger actor with state
      logger = Logger.Logger<Text>(state);
      NumberOfText := 0;

    };

  // Add a set of messages to the log.
  public shared (msg) func append(msgs: [Text]) {
    //assert(Option.isSome(Array.find(allowed, func (id: Principal) : Bool { msg.caller == id })));
    
    for (msg in msgs.vals()) {
         logger.append(Array.make(msg));
         NumberOfText+=1;
         if (NumberOfText >= ACTOR_SIZE) {
            roll_over_actors();
         }
    }
    
  };

  // Return log stats, where:
  //   start_index is the first index of log message.
  //   bucket_sizes is the size of all buckets, from oldest to newest.
  public query func stats() : async Logger.Stats {
    logger.stats()
  };

  // Return the messages between from and to indice (inclusive).
  public shared query (msg) func view(from: Nat, to: Nat) : async Logger.View<Text> {
    //assert(msg.caller == OWNER);
    logger.view(from, to)
  };

  

  // Drop past buckets (oldest first).
  public shared (msg) func pop_buckets(num: Nat) {
    assert(msg.caller == OWNER);
    logger.pop_buckets(num)
  }


  */
}
