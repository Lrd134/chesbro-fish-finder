class UsersController < ApplicationController
  before_action :set_user, only: %i[ edit update destroy show username ]

  def index
    @users = User.all
  end

  def show
    @current_user = current_user
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
    is_user_allowed_to_modify?(@user) ? render(:edit) : redirect_to(users_path, notice: "You're not allowed to modify this resource.")
  end

  def update
    if is_user_allowed_to_modify?(@user) 
      @user.update(user_params)
      redirect_to user_path(@user)
    else
      redirect_to users_path notice: "You're not allowed to modify this resource."
    end
  end

  def destroy
    if is_user_allowed_to_modify?(@user)
      @user.destroy
      redirect_to users_path, notice: "User deleted successfully."
    else
      redirect_to user_path(@user), notice: "You're not allowed to delete this user."
    end
  end

  def username
    is_user_allowed_to_modify?(@user) ? render(:username, notice: "Username strongly suggested.") : redirect_to(users_path)
  end

  def set_user
    @user = User.find_by(id: params[:id])  
  end
  
end
