class ApplicationController < ActionController::Base
  def home
    render "application/home"
  end

  def current_user
    @user = User.find_by(id: session[:uid])
  end

  def user_params
    params.require(:user).permit(:password, :username, :email)
  end

  def is_user_allowed_to_modify?(model)
    model.user_id == current_user.id || current_user.is_admin?
  end
  
end
