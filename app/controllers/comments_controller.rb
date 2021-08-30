class CommentsController < ApplicationController
  before_action :set_comment, only: [ :update, :show, :edit, :destroy ]
  before_action :set_user, only: %i[ show new ]
  before_action :set_fish, only: %i[ new edit ]
  before_action :is_user_allowed_to_modify, only: %i[ edit update destroy ]

  def index
    @comments = Comment.all
  end

  def show
    @comment.nil? ? redirect_to(comments_path, notice: "Comment not found.") : render(:show)
  end

  def new
    @comment = Comment.new
  end

  def create
    if Fish.slugs_match?(params, 'comment')
      params[:comment][:user_id] = current_user.id
      @comment = Comment.create(comment_params)
      if @comment.valid?
        redirect_to fish_path(@comment.fish_slug, @comment.category_slug), notice: "Comment successfully created."
      else
        render :new
      end
    else
      redirect_to fish_path(params['fish_slug'], params['cat_slug']), notice: "Fish not found."
    end
  end

  def edit
    if @comment.fish == @fish
        render :edit
    else
      redirect_to fish_path(@comment.fish_slug, @comment.category_slug), notice: "Error has occured"
    end
  end

  def update
    @comment.update(comment_params)
    if @comment.valid?
      redirect_to fish_path(@comment.fish_slug, @comment.category_slug), notice: "Updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to fish_index_path, notice: "Comment removed successfully."
  end
  
  def set_user
    @user = current_user
  end

  def set_comment
    @comment = Comment.find_by(id: params['id'])
  end

  def comment_params
    params.require(:comment).permit(:user_id, :fish_id, :body)
  end
  def is_user_allowed_to_modify
    if @comment.user_id != current_user.id
      redirect_to root_path, notice: "Not allowed to modify that."
    end
  end
  
end
