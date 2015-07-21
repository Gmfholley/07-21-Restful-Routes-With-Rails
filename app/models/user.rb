class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  has_many :posts
  
  #TODO - create a callback to run this automatically at validation
  
  def convert_password
    self.password = BCrypt::Password.create(self.password)
  end
  
  def valid_password?(password)
    if !(BCrypt::Password.new(self.password) == password)
      errors.messages["login"] = "Login Failed."
    end
    return errors.messages.empty?
  end
  
end 