class UsersController < ApplicationController
  before_action :current_user, only: %i[ show edit update destroy ]

  def index
    @users = User.all
  end

  def show
    
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


end
