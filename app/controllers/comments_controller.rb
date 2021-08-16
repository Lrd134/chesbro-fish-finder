class CommentsController < ApplicationController

  def index
    @comments = Comment.all
  end
  def show
    @category = Comment.find_by(id: params[:id])
    @comment.nil? ? redirect_to(comments_path) : render(:show)
  end
end
