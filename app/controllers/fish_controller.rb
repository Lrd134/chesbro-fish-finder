class FishController < ApplicationController
  before_action :set_fish, :set_user, only: %i[ show edit destroy ]

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
    @fish.nil? ? redirect_to(fish_index_path) : render(:edit)
  end

  def update
    @fish = Fish.find(params[:id])
    if @fish.user_id == current_user.id || current_user.admin?
      @fish.update(fish_params)
    redirect_to fish_path @fish.slug, @fish.category.slug
  end
  
  def destroy
    
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
