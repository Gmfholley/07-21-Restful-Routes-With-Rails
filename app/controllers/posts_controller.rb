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
  
  def edit_post_form
    current_user
    @post = Post.find_by_id(params["id"])
    if post_belongs_to_user?
      render "edit_post_form"
    else
      redirect_to "/users/#{@user.id}/posts"
    end
  end
  
  #TODO - handle post not found errors
  
  def edit_post
    current_user
    @post = Post.find_by_id(params["posts"]["id"])
    if post_belongs_to_user?
      if @post.update(params["posts"].permit(:name))
        redirect_to "/users/#{@user.id}/posts"
      else
        render "edit_post_form"
      end
    else
      redirect_to "/users/#{@user.id}/posts"
    end
  end
  
  def post
    @user = User.find(params["user_id"])
    @post = Post.find(params["id"])
  end
  
  def vote
    current_user
    @post = Post.find(params["id"])
    if @post.can_vote?(@user.id) && !@post.has_voted?(@user.id)
      @post.users << @user
    end
    render :json => @post.to_json(:include => :users)
  end
  
  def unvote
    current_user
    @post = Post.find(params["id"])
    if @post.can_vote?(@user.id) && @post.has_voted?(@user.id)
      @post.users.delete(@user)
    end
    render :json => @post.to_json(:include => :users)
  end
  
end