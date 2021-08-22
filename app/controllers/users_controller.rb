class UsersController < ApplicationController
  before_action :current_user, only: %i[ edit update destroy username ]

  def index
    @users = User.all
  end

  def show
    @current_user = current_user
    @user = User.find_by(id: params['id'])
    if !@user.nil?
      render :show
    else
      redirect_to users_path, notice: "User not found."
    end
    
  end

  def new
    @user = User.new
  end
  def edit
  end
  def update

  end

  def destroy
    @user.destroy
  end

  def username
    is_user_allowed_to_modify?(@user) ? render(:username, notice: "Username strongly suggested.") : redirect_to(users_index_path)
  end

end
