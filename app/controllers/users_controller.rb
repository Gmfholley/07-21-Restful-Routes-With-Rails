class UsersController < ApplicationController
  
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

  def delete_profile_form
    current_user
  end
  
  def delete_profile
    current_user
    if @user.delete
      redirect_to "/"
    else
      render delete_profile_form
    end
  end
  
  def edit_profile_form
    current_user
  end
  
  def edit_profile
    current_user
    params["users"]["password"] = BCrypt::Password.create(params["users"]["password"])
    if @user.update(params["users"].permit(:email, :password))
      redirect_to "/users/#{@user.id}"
    else
      render "edit_profile_form"
    end
  end
  
  def profile
    @user = User.find(params["id"])
  end

end
