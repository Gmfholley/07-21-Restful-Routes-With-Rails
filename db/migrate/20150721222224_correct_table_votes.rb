class CorrectTableVotes < ActiveRecord::Migration
  def change
    
    change_column :posts_users, :post_id, 'integer USING CAST(post_id AS integer)'
    change_column :posts_users, :user_id, 'integer USING CAST(user_id AS integer)'
    
  end
end
