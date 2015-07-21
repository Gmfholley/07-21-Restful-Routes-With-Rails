module UsersHelper
  
  def current_user
    if session[:id]
      @user = User.find(session[:id].to_i)
    else
      session.clear
      redirect "/"
    end 
  end 
end
