class FishController < ApplicationController
  before_action :set_fish, :set_user, only: %i[ show edit destroy ]
  before_action :check_session_for_user, only: %i[ new create destroy update edit ]

  def index
    @fish = Fish.all
  end
  def show
    @comment = Comment.new
  end
  def new
    @fish = Fish.new
  end
  
  def create
    @fish = Fish.create(fish_params)
    redirect_to fish_path(@fish.slug, @fish.category.slug)
  end

  def edit
    if !is_user_allowed_to_modify?(@fish) && @fish.nil?
      redirect_to fish_index_path
    end
  end

  def update
    @fish = Fish.find(params[:id])
    if is_user_allowed_to_modify?(@fish)
      @fish.update(fish_params)
    else
      redirect_to fish_index_path
    end
    redirect_to fish_path @fish.slug, @fish.category.slug
  end
  
  def destroy
    is_user_allowed_to_modify?(@fish) ? @fish.destroy : redirect_to(fish_index_path)
    # redirect_to users_fish_path
    redirect_to fish_index_path
  end

  private
    
    def set_fish
      @fish = Fish.find_by_slug(params[:fish_slug])
    end

    def set_user
      @user = current_user
    end
    def check_session_for_user
      current_user.nil? ? redirect_to(:fish_index, notice: "Not Logged In") : nil
    end
    def fish_params
      params.require(:fish).permit(:fish_image, :content, :title, :user_id)
    end

end
