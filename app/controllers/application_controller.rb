class ApplicationController < ActionController::Base
  def home
    render "application/home"
  end

  def current_user
    User.find_by(id: session[:uid])
  end

  def set_fish
    @fish = Fish.find_by_slug(params[:fish_slug])
  end
  
  def user_params
    params.require(:user).permit(:password, :username, :email)
  end


end
