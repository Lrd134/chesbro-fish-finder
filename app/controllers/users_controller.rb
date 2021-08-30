class UsersController < ApplicationController
  before_action :set_user, only: %i[ edit update destroy show username categories fish ]
  before_action :user_exists, only: %i[ create ]
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
  
  def create
    # field login signup button video
    # remove is_user_allowed_to_modify
    @user = User.create user_params 
    if @user.valid?
        session[:uid] = @user.id
        @user.username.empty? ? redirect_to(create_username_path(@user)) : redirect_to(user_path(@user))
    else
      render :'users/new'
    end
  end

  def edit
    is_user_allowed_to_modify?(@user) ? render(:edit) : redirect_to(users_path, notice: "You're not allowed to modify this resource.")
  end

  def update
    if is_user_allowed_to_modify?(@user) 
      @user.update(user_params)
      if @user.valid?
        redirect_to user_path(@user)
      else
        render :edit
      end
    else
      redirect_to users_path notice: "You're not allowed to modify this resource."
    end
  end

  def destroy
    if is_user_allowed_to_modify?(@user)
      @user.fish.each { | fish | fish.destroy }      
      @user.destroy
      redirect_to logout_path
    else
      redirect_to user_path(@user), notice: "You're not allowed to delete this user."
    end
  end

  def login
  end

  def categories
    render :categories
  end
  
  def fish
    render :fish
  end
  
  def user_exists
    if params[:user][:username].empty?
      @user = User.find_by(email: params[:user][:email])
      if @user.username != params[:user][:username]
        @user = nil
      end
    end
    @user.nil? ? nil : redirect_to(login_path, notice: "User exists already")
  end

  def username
    is_user_allowed_to_modify?(@user) ? render(:username, notice: "Username strongly suggested.") : redirect_to(users_path)
  end

  def set_user
    @user = User.find_by(id: params[:id])  
  end
  
end
