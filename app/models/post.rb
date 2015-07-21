class Post < ActiveRecord::Base
  validates :name, presence: true
  validates :user, presence: true
  belongs_to :user
  
  has_and_belongs_to_many :users
  
  def num_votes
    self.users.length
  end
  
end