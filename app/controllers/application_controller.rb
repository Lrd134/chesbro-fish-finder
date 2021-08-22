class ApplicationController < ActionController::Base
  def home
    render "application/home"
  end

  def current_user
    @user = User.find_by(id: session[:uid])
  end

  def set_fish
    @fish = Fish.find_by_slug(params[:fish_slug])
  end
  
  def user_params
    params.require(:user).permit(:password, :username, :email)
  end

  def is_user_allowed_to_modify?(model_instance)
    if model_instance.class != User
      model_instance.user_id == current_user.id || current_user.admin?
    else
      model_instance.id == current_user.id || current_user.admin?
    end
  end
  
end
