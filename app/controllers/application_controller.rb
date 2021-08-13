class ApplicationController < ActionController::Base
  def home
    render "application/home"
  end

  def current_user
    @user = User.find_by(id: session[:uid])
  end
end
