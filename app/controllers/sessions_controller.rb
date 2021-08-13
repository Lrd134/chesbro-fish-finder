class SessionsController < ApplicationController
  def omniauth
    user = User.from_omniauth(request.env['omniauth.auth'])
    session[:uid] = user.id
    redirect_to user_path(user)
  end

end
