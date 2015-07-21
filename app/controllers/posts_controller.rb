class PostsController < ApplicationController
  include PostsHelper
  
  def index
    @user = User.find(params["id"])
    @posts = Post.where("user_id" => @user.id)
  end
  
  def new_post_form
    current_user
    @post = Post.new
  end
  
  def new_post
    current_user
    @post = Post.new(params["posts"].permit(:name, :user_id))
    if @post.save
      redirect_to "/users/#{@user.id}/posts"
    else
      render "new_post_form"
    end
  end
  
  def delete_post_form
    current_user
    @post = Post.find(params["id"])
    if post_belongs_to_user?
      render "delete_post_form"
    else
      redirect_to "/users/#{@user.id}/posts"
    end
  end
  
  def delete_post
    current_user
    @post = Post.find(params["id"])
    if post_belongs_to_user?
      if @post.delete
        @message = "Successfully deleted."
      else
        @message = "Failed to delete."
      end
    end
    @posts = Post.where("user_id" => @user.id)
    render "index"    
  end
  
  def edit_story_form
    current_user
    @post = Post.find(params["id"])
    if post_belongs_to_user?
      render "edit_story_form"
    else
      redirect_to "/users/#{@user.id}/posts"
    end
  end
  
  def edit_story
    current_user
    @post = Post.find(params["posts"]["id"])
    if post_belongs_to_user?
      if @post.update(params["posts"])
        redirect_to "users/#{@user.id}/posts/#{@post.id}"
      else
        render "posts/edit_story"
      end
    else
      redirect_to "/users/#{@user.id}/posts"
    end
  end
  #
  # get "/edit_story/:id" do
  #   current_user
  #   @story = Story.find(params["id"])
  #   if @user.id == @story.user_id
  #     erb :"stories/edit_story"
  #   else
  #     redirect "/users/#{@user.id}/stories"
  #   end
  # end
  #
  # put "/edit_story/:id" do

  # end
  #
  # get "/users/:user_id/stories/:id" do
  #   @user = User.find(params["user_id"])
  #   @story = Story.find(params["id"])
  #   erb :"stories/single_story"
  # end
  
end