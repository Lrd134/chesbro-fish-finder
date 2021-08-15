class FishController < ApplicationController
  before_action :set_fish, only: %i[ show edit update destroy ]
  before_action :set_user, only: [ :new ]
  
  def index
    @fish = Fish.all
  end
  
  def new
    @fish = Fish.new
  end
  
  def create
    @fish = Fish.create(fish_params)
    redirect_to fish_path(@fish.slug, @fish.category.slug)
  end

  def edit
    @fish.nil? redirect_to(fish_index_path)
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

    def set_user
      @user = current_user
    end

    def fish_params
      params.require(:fish).permit(:fish_image, :content, :title, :user_id)
    end
end
