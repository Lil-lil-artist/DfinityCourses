import Text "mo:base/Text";
import Nat "mo:base/Nat";
actor Counter {

  stable var counter = 0;

  // Get the value of the counter.
  public query func get() : async Nat {
    return internalGet();
  };
  func internalGet() :  Nat {
    return counter;
  };

  // Set the value of the counter.
  public func set(n : Nat) : async () {
    counter := n;
  };

  // Increment the value of the counter.
  public func inc() : async () {
    counter += 1;
  };
  public type HeaderField =  (Text,Text);
  public type Key = Text;
  public type Path = Text;
  public type ChunkId =Nat;
  public type SetAssetContentArguments = {
    key :Key;
    sha256 : ?[Nat8];
    chunk_ids :[ChunkId];
    content_encoding :Text;
  };
  public type StreamingCallbackHttpResponse ={
    token : ?StreamingCallbackToken;
    body :[Nat8];
  };
  public type StreamingCallbackToken ={
    key :Text;
    sha256 : ?[Nat8];
    index :Nat;
    content_encoding :Text;
  };
  
  public type StreamingStrategy ={
    #Callback :{
        token: StreamingCallbackToken;
        callback: shared query StreamingCallbackToken -> async StreamingCallbackHttpResponse;
    };
  };

  public type HttpRequest =  {
      body: [Nat8];
      headers:  [HeaderField];
      method: Text;
      url: Text;
  };
  public type HttpResponse =  {
      body: Blob;
      headers:   [HeaderField];
      status_code: Nat16;
      streaming_strategy: ?StreamingStrategy;
  };
  
  public shared query func http_request(request: HttpRequest) :async HttpResponse{
      
      {
      
      body =Text.encodeUtf8("<html><body><h1>counter:"#Nat.toText(internalGet())#"</h1></body></html>");
      headers =[];
      streaming_strategy=null;
      status_code=200;
      }
      
  }
};
