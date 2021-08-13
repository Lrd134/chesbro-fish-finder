class User < ApplicationRecord
  has_secure_password
  def display
    self.username
  end

  def display_google_account
      "#{self.email} #{self.provider.split("_").map{ | w | w.capitalize }.join("_")}"
  end
  def self.from_omniauth(response)
    @user = User.find_by(uid: response['uid'])
    if @user.nil?
      User.create(uid: response['uid'], provider: response[:provider], email: response['info']['email'], password: "omniauthiuoj8hknl4edfvsecure")
    else
      @user
    end
  end
end
