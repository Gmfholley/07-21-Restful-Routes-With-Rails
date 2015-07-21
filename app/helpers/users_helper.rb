module UsersHelper
  
  # cache = ActiveSupport::Cache::MemoryStore.new
  #
  # cache.read('city')   # => nil
  # cache.write('city', "Duckburgh")
  # cache.read('city')   # => "Duckburgh"
  
  def current_user
    if session_id
      @user = User.find(session_id)
    else
      clear_session
      redirect "/"
    end 
  end 
  
  def set_user_if_available
    if session_id
      @user = User.find(session_id)
    else
      @user = User.new
    end
  end
  
  def session_id
    cookies[:id]
  end
  
  def clear_session
    cookies[:id] = nil
  end
  
  def save_user_and_set_session
    @user.save
    set_session
  end
  
  def set_session
    cookies[:id] = @user.id
  end
  
  def find_user_by_email
    @user = User.where("email" => params["users"]["email"]).first
  end
  
  
end
