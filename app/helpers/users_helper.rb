module UsersHelper
  
  def current_user
    if session[:id]
      @user = User.find(session[:id].to_i)
    else
      session.clear
      redirect "/"
    end 
  end 
  
  def set_user_if_available
    if session["id"]
      @user = User.find(session["id"])
    else
      @user = User.new
    end
  end
  
  def save_user_and_set_session
    @user.save
    session[:id] = @user.id
  end
  
end
