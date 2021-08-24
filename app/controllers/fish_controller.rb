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
    set_user
    @fish = Fish.new
  end
  
  def create
    set_user
    @fish = Fish.create(fish_params)
    if @fish.valid?
      redirect_to fish_path(@fish.slug, @fish.category.slug), notice: "Fish created successfully"
    else
      render :new
    end
  end

  def edit
    if !is_user_allowed_to_modify?(@fish)
      redirect_to fish_index_path, notice: "You're not allowed to modify this resource."
    end
  end

  def update
    @fish = Fish.find(params[:id])
    if is_user_allowed_to_modify?(@fish)
      @fish.update(fish_params)
      if @fish.valid?
        redirect_to fish_path @fish.slug, @fish.category.slug, notice: "Updated fish successfully"
      else
        render :edit
      end
    else
      redirect_to fish_index_path, notice: "Not allowed to modify this resource."
    end
    
  end
  
  def destroy
    if is_user_allowed_to_modify?(@fish)
      @fish.comments.each { | c | c.destroy }
      @fish.destroy
      redirect_to fish_index_path, notice: "Desroyed fish successfully"
    else
      redirect_to fish_path(@fish.slug, @fish.category_slug), notice: "Not allowed to modify this fish"
    end
  end

  def newest
    @fish = Fish.newest
    set_user
    render :show
  end

  def recent
    set_user
    @fish = Fish.recent
    render :show
  end

  private
    

    def set_user
      @user = current_user
    end

    def check_session_for_user
      current_user.nil? ? redirect_to(:fish_index, notice: "Not Logged In") : nil
    end
    
    def fish_params
      params.require(:fish).permit(:fish_image, :content, :title, :user_id, :category_id)
    end

end
