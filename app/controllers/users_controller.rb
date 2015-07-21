class UsersController < ApplicationController
  
  include UsersHelper
  
  def login
    session.clear
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
  #  Rails.logger.debug params.inspect
    @user = User.new(params["users"].permit(:email, :password))
    @user.convert_password
    if @user.valid?
      save_user_and_set_session
      redirect_to "/users/#{@user.id}"
    else
      render "create_form"
    end
  end
  
  def login_user
    find_user_by_email
    if !@user.nil? && @user.valid_password?(params["users"]["password"])
      set_session
      redirect_to "/users/#{@user.id}"
    else
      render "login"
    end
  end

  #post "/users/login" do

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
 def profile
   @user = User.find(params["id"])
 end

end
