class Post < ActiveRecord::Base
  validates :name, presence: true
  validates :user, presence: true
  belongs_to :user
  
  has_and_belongs_to_many :users
  
  # returns a Boolean if this user can vote for this post
  #
  # users_id - Integer representing a user's id
  #
  # returns a Boolean
  def can_vote?(users_id)
    (users_id != self.user_id && !users_id.blank?)
  end
  
  # returns a Boolean indicating if this user has voted
  #
  # users_id - Integer of the Id of the user to check
  #
  # returns a Boolean
  def has_voted?(users_id)
    votes.select{|voter| voter.id == users_id}.length > 0 
  end
  
  # returns the number of votes this post has
  #
  # returns an Integer
  def num_votes
    self.users.length
  end
  
  # returns the array of Users who voted for the post
  #
  # returns an Array of Users
  def votes
    self.users
  end
  
end