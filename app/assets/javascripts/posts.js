// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// returns the content div
//
// returns an Element
function get_content(){
  return document.getElementById("content");
}

// returns the post_id
//
// returns an Integer
function get_post_id(){
  return get_content().getAttribute("data-id");
}


// returns the post_id
//
// returns an Integer
function get_session_id(){
  return get_content().getAttribute("data-session-id");
}

// returns the unvote Element
//
// Returns an Element
function get_unvote_image(){
  return document.getElementById("unvote");
}

// returns the vote Element
//
// Returns an Element
function get_vote_image(){
  return document.getElementById("vote");
}

function add_checkmark_img(){
  var img = document.createElement("img");
  img.src = "http://www.entypo.com/images/check.svg";
  img.classList.add("vote__icon");
  img.setAttribute("title", "click to unvote");
  img.id = "unvote"
  get_content().insertBefore(img, document.getElementsByClassName("vote__text")[0].nextSibling);
  img.addEventListener("click", "unvote");
}

function add_vote_img(){
  var img = document.createElement("img");
  img.src = "http://www.entypo.com/images/check.svg";
  img.classList.add("vote__icon");
  img.setAttribute("title", "click to vote");
  img.id = "unvote"
  get_content().insertBefore(img, document.getElementsByClassName("vote__text")[0].nextSibling);
  img.addEventListener("click", "vote");
}

function vote (){
  var request = new XMLHttpRequest();
  request.open("get", "/posts/" + get_post_id() + "/vote")
  
  request.addEventListener("loadstart", function(){
    var img = get_vote_image();
    get_content().removeChild(img);
    
  });
  
  request.addEventListener("load", function(){
    var post = JSON.parse(this.response);
    var includes = false;
    for (i=0; i < post.users.length; i++) {
      if (post.users[i].id == get_session_id()){
        includes = true;
      }
    }
    if (includes) {
      add_checkmark_img();
    } 
    else {
      add_vote_img();
    }

    
  });
  
  request.send()
}


function unvote() {
  var request = new XMLHttpRequest();
  request.open("get", "/posts/" + get_post_id() + "/unvote")
  
  request.addEventListener("loadstart", function(){
    var img = get_unvote_image();
    get_content().removeChild(img);
    
  });
  
  request.addEventListener("load", function(){
    var post = JSON.parse(this.response);
    var includes = false;
    for (i=0; i < post.users.length; i++) {
      if (post.users[i].id == get_session_id()){
        includes = true;
      }
    }
    if (includes) {
      add_checkmark_img();
    } 
    else {
     add_vote_img(); 
    }
    
    
  });
  request.send();
}


window.onload = function(){
  alert("yes");
  var v = document.getElementById("vote");
  var u = document.getElementById("unvote")
  if (v != null){
    v.addEventListener("click", vote);
  }
  if (u != null){
    u.addEventListener("click", unvote);
  }
}