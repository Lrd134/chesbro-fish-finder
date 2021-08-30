class FishController < ApplicationController
  before_action :set_fish_by_id, only: [ :update ]
  before_action :set_fish, :set_user, only: %i[ show edit destroy ]
  before_action :check_session_for_user, only: %i[ new create destroy update edit ]
  before_action :is_user_allowed_to_modify, only: %i[ edit update destroy ]
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
    params[:fish][:user_id] = current_user.id
    @fish = Fish.create(fish_params)
    if @fish.valid?
      redirect_to fish_path(@fish.slug, @fish.category_slug), notice: "Fish created successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @fish.update(fish_params)
    if @fish.valid?
      redirect_to fish_path @fish.slug, @fish.category.slug, notice: "Updated fish successfully"
    else
      render :edit
    end
  end
  
  def destroy
    @fish.destroy
    redirect_to fish_index_path, notice: "Desroyed fish successfully"
  end

  def newest
    @fish = Fish.newest
    redirect_to fish_path(@fish.slug, @fish.category_slug)
  end

  def recent
    @fish = Fish.recent
    redirect_to fish_path(@fish.slug, @fish.category_slug)
  end

  def solved
    @fish = Fish.last_solved
    redirect_to fish_path(@fish.slug, @fish.category_slug)
  end

  private
    

    def set_user
      @user = current_user
    end

    def set_fish_by_id
      @fish = Fish.find_by(id: params[:id])
    end
    
    def check_session_for_user
      current_user.nil? ? redirect_to(:fish_index, notice: "Not Logged In") : nil
    end
    
    def fish_params
      params.require(:fish).permit(:fish_image, :content, :title, :user_id, :category_id)
    end

    def is_user_allowed_to_modify
      if @fish.user_id != current_user.id
        redirect_to root_path, notice: "Not allowed to modify that."
      end
    end
end
