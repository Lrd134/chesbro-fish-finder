class UsersController < ApplicationController
  before_action :current_user, only: %i[ show edit update destroy ]

  def index
    @users = User.all
  end

  def show
    
  end


  def edit
  end

  def create
  end
  def update

  end

  def destroy
    @user.destroy
  end


end
