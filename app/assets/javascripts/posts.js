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


function get_unvote_image(){
  
}

// returns the vote Element
//
// Returns an Element
function get_vote_image(){
  return document.getElementById("vote");
}

function vote (){
  var request = new XMLHttpRequest();
  request.open("get", "/posts/" + get_post_id() + "/vote")
  
  request.addEventListener("loadstart", function(){
    var img = get_vote_image();
    get_content().removeChild(img);
    
  });
  
  request.addEventListener("load", function(){
    
    var img = document.createElement("img");
    img.src = "http://www.entypo.com/images/check.svg";
    img.classList.add("vote__icon");
    img.setAttribute("title", "click to unvote");
    img.id = "unvote"
    get_content().insertBefore(img, document.getElementByClassName("vote__icon")[0].nextSibling);
    
  });
  
  request.send()
}


function unvote() {
  
}


window.onload = function(){
  document.getElementById("vote").addEventListener("click", vote)
  document.getElementById("unvote").addEventListener("click", unvote)
}