class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  has_many :posts
  
  has_and_belongs_to_many :posts
  validates :posts, presence: true
  
  #TODO - create a callback to run this automatically at validation
  
  # encrypts the password
  #
  # returns the new password
  def convert_password
    self.password = BCrypt::Password.create(self.password)
  end
  
  # checks if this is a valid password
  #
  # returns a Boolean
  def valid_password?(password)
    if !(BCrypt::Password.new(self.password) == password)
      errors.messages["login"] = "Login Failed."
    end
    return errors.messages.empty?
  end
  
  
  # returns an Array of Posts, which belong to this user
  #
  # returns an Array of Posts
  def my_posts
    Post.where(user_id: self.id)
  end
  
end 