class FishController < ApplicationController
  before_action :set_fish, only: %i[ show edit update destroy ]
  
  def index
    @fish = Fish.all
  end
  
  def new
    @fish = Fish.new
  end
  
  def create
    byebug
  end

  def edit
  end

  def update
    byebug
  end
  
  def destroy
    byebug
  end
  
  private
    
    def set_fish
      @fish = Fish.find_by_slug(params[:fish_slug])
    end

    def fish_params
      params.require(:fish).permit(:image, :content, :title, :user_id)
    end
end
