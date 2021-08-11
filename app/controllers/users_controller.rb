class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

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
