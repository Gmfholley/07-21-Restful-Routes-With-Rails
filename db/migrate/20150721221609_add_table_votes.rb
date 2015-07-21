class AddTableVotes < ActiveRecord::Migration
  def change
    create_table(:posts_users, id: false) do |t|
      t.text :post_id
      t.text :user_id
    end
  end
end
