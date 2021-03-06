class User < ApplicationRecord
  has_many :comments
  has_many :fish
  has_many :categories, through: :fish
  has_secure_password
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :username, uniqueness: true


  def self.from_omniauth(response)
    @user = User.find_by(uid: response['uid'])
    if @user.nil?
      User.create(uid: response['uid'], provider: response[:provider], email: response['info']['email'], password: "omniauthiuoj8hknl4edfvsecure")
    else
      @user
    end
  end

  def self.seed_by_hash(user_hash)
    @user = User.find_by(username: user_hash[:username])
    @user.nil? ? User.create(user_hash) : @user
  end

  def display
    if self.username.nil?
      self.email.capitalize
    else
      self.username.capitalize
    end
  end

end
