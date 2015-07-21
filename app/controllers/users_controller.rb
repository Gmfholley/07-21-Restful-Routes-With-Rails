class UsersController < ApplicationController
  
  include UsersHelper
  
  def login
    session[:id] = nil
    @user = User.new
  end
  
  def index
    set_user_if_available
    @users = User.all
  end
  
  def create_form
    @user = User.new
  end
  
  def create_user
    Rails.logger.debug params.inspect
    @user = User.new(params["users"].permit(:email, :password))
    @user.convert_password
    if @user.valid?
      @user.save
      session[:id] = @user.id
      redirect "/users/#{@user.id}"
    else
      render "create_form"
    end
    
  end
  # post "/new_user" do
#     params["users"]["password"] = BCrypt::Password.create(params["users"]["password"])
#
#     if @user.valid?
#       @user.save
#       session[:id] = @user.id
#       redirect "/users/#{@user.id}"
#     else
#       erb :"users/create_user"
#     end
#   end
 #
 #  post "/users/login" do
 #    @user = User.where("email" => params["users"]["email"]).first
 #    if !@user.nil? && @user.valid_password?(params["users"]["password"])
 #      session[:id] = @user.id
 #      redirect "/users/#{@user.id}"
 #    else
 #      erb :"users/login"
 #    end
 #  end
 #
 #  get "/delete_profile" do
 #    current_user
 #    erb :"users/delete_user"
 #  end
 #
 #  delete "/users" do
 #    current_user
 #    if @user.delete(params["id"])
 #      redirect "/"
 #    else
 #      erb :"users/delete_user"
 #    end
 #  end
 #
 #  get "/edit_profile" do
 #    current_user
 #    erb :"users/edit_user"
 #  end
 #
 #  put "/users" do
 #    current_user
 #    if @user.update(params["users"])
 #      redirect "/users/#{@user.id}"
 #    else
 #      erb :"users/edit_user"
 #    end
 #  end
 #
 #  get "/users/:id" do
 #    @user = User.find(params["id"])
 #    erb :"users/single_user"
 #  end
end
