class CommentsController < ApplicationController
  before_action :set_comment, only: [ :update, :show, :edit, :destroy ]
  before_action :current_user

  def index
    @comments = Comment.all
  end

  def show
    @comment.nil? ? redirect_to(comments_path) : render(:show)
  end

  def create
    if @user.id == params['comment']['user_id'].to_i && Fish.find_by_slug(params['fish_slug']).id == params['comment']['fish_id'].to_i
      @comment = Comment.create(comment_params)
      if @comment.nil?
        redirect_to fish_path(@comment.fish_slug, @comment.category_slug), notice: "Comment was too short, length must be greater than 15"
      else
        redirect_to fish_path(@comment.fish.slug, @comment.fish.category.slug), notice: "Comment successfully created."
      end
    else
      redirect_to fish_path(params['fish_slug'], params['cat_slug']), notice: "Error occurred"
    end
  end

  def edit
    if @comment.fish == Fish.find_by_slug(params['fish_slug'])
      if @comment.user == @user
        render :edit
      else
        redirect_to fish_path(@comment.fish_slug, @comment.category_slug), notice: "You don't own this resource."
      end
    else
      redirect_to fish_path(@comment.fish_slug, @comment.category_slug), notice: "Error has occured"
    end
  end

  def update
    @comment.update(comment_params)
    if @comment.body == params['comment']['body']
      redirect_to fish_path(@comment.fish_slug, @comment.category_slug), notice: "Updated successfully."
    else
      redirect_to fish_path(@comment.fish_slug, @comment.category_slug), notice: "Update failed."
    end
  end

  def destroy
    if is_user_allowed_to_modify?(@comment)
      @comment.destroy
      redirect_to fish_index_path, notice: "Comment removed successfully."
    else
      redirect_to fish_path(@comment.fish_slug, @comment.category_slug), notice: "Not allowed to modify this resource."
    end
  end

  def set_comment
    @comment = Comment.find_by(id: params['id'])
  end
  
  def comment_params
    params.require(:comment).permit(:user_id, :fish_id, :body)
  end

end
