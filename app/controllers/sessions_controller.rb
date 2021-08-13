class SessionsController < ApplicationController
  def omniauth
    user = User.from_omniauth(request.env['omniauth.auth'])
    session[:uid] = user.id
    redirect_to user_path(user)
  end
  def login
    @user = User.new
  end
  def create
    if params['user']['username'].empty?
      @user = User.find_by(username: params['user']['email'])
    else
      @user = User.find_by(username: params['user']['username'])
    end
    
    if @user.nil?
      @user=(User.create(user_params))
    end

    if @user.authenticate(params['user']['password'])
      session[:uid] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to root_path
    end
  end
  def destroy
    session.delete :uid
    redirect_to root_path
  end
end
