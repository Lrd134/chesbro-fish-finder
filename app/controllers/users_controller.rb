class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    @users = User.all
  end

  def show
    set_user
  end

  def new
    if session[:omniauth_data].nil?
      @user = User.new
    else
      byebug
    end
  end
  def edit
  end

  def create
  end
  def update

  end

  def destroy

  end

  private
    def set_user
      @user = User.find(params[:id])
    end
    def user_params
      params.fetch(:user, {})
    end
end
