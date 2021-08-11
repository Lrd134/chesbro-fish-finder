class SessionsController < ApplicationController
  def create
    session[:omniauth_data] = request.env['omniauth.auth']
    redirect_to :new_user_path
  end
end
