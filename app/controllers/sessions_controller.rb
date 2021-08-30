class SessionsController < ApplicationController
  def omniauth
    @user = User.from_omniauth(request.env['omniauth.auth'])
    session[:uid] = @user.id
    if @user.username.nil?
      redirect_to create_username_path(@user)
    else
      redirect_to user_path(@user)
    end
  end

  def destroy
    session.delete :uid
    redirect_to root_path
  end
end
