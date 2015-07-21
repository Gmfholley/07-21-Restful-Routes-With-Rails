module PostsHelper
  
  def post_belongs_to_user?
    @post.user_id == @user.id
  end
  
end
