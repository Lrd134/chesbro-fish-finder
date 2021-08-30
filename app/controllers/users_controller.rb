class UsersController < ApplicationController
  before_action :set_user, only: %i[ edit update destroy show username categories fish ]
  before_action :user_exists, only: %i[ create ]
  before_action :is_user_allowed_to_modify, only: %i[ edit update destroy username ]
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
  end

  def update
    @user.update(user_params)
    if @user.valid?
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to logout_path
  end

  def login
    @user = User.new
  end

  def logging_in
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.authenticate params[:user][:password]
        session[:uid] = @user.id 
        redirect_to user_path @user
      end
    else
      @user.errors.add("Invalid Data")
      render :login
    end
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
    render :username
  end

  def set_user
    @user = User.find_by(id: params[:id])  
  end
  
  def is_user_allowed_to_modify
    if @user != current_user
      redirect_to root_path, notice: "Not allowed to modify that."
    end
  end
end
