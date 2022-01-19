import { FuncClass } from "@dfinity/candid/lib/cjs/idl";
import { hello } from "../../declarations/hello";

async function post(){
    let post_button =document.getElementById("post");
    post_button.disabled = true;
    let error = document.getElementById("error");
    error.innerText = "";
    let textarea  = document.getElementById("message");
    let otp = document.getElementById("otp").value;
    let text = textarea.value;
    try{
      await hello.post(otp,text);
      textarea.value = "";
    } catch (err){
      console.log(err)
      error.innerText= "Post Failed!";
    }
    
    post_button.disabled=false;
}
var num_posts = 0;
async function load_posts(){
  let posts_section = document.getElementById("posts");
  let posts = await hello.posts();
  console.log("posts.length="+posts.length);
  console.log("num_posts="+num_posts);
  if (num_posts == posts.length) return ;
  posts_section.replaceChildren([]);
  num_posts =posts.length;
  for (var i=0; i<posts.length; i++){
    let post = document.createElement("p");
    post.innerText = posts[i]
    posts_section.appendChild(post)
  }
}

function load(){
  let post_button = document.getElementById("post");
  post_button.onclick =post;
  load_posts();
  setInterval(load_posts,3000)
}

window.onload = load