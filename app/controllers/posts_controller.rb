class PostsController < ApplicationController
  
  
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
  
  def delete_post
    current_user
    @post = Post.find(params["id"])
    if post_belongs_to_user?
      render "delete_post_form"
    else
      redirect_to "/users/#{@user.id}/posts"
    end
  end
  #
  # get "/delete_story/:id" do
  #   current_user
  #   @story = Story.find(params["id"])
  #   if @user.id == @story.user_id
  #     erb :"stories/delete_story"
  #   else
  #     redirect "/users/#{@user.id}/stories"
  #   end
  # end
  #
  # delete "/delete_story/:id" do
  #   current_user
  #   @story = Story.find(params["id"])
  #   if @user.id == @story.user_id
  #     if @story.delete
  #       return "Success."
  #     else
  #       return "Failed."
  #     end
  #   else
  #     redirect "/users/#{@user.id}/stories"
  #   end
  # end
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
  #   current_user
  #   @story = Story.find(params["stories"]["id"])
  #   if @user.id == @story.user_id
  #     if @story.update(params["stories"])
  #       redirect "users/#{@user.id}/stories/#{@story.id}"
  #     else
  #       erb :"stories/edit_story"
  #     end
  #   else
  #     redirect "/users/#{@user.id}/stories"
  #   end
  # end
  #
  # get "/users/:user_id/stories/:id" do
  #   @user = User.find(params["user_id"])
  #   @story = Story.find(params["id"])
  #   erb :"stories/single_story"
  # end
  
end