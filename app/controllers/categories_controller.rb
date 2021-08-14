class CategoriesController < ApplicationController

  def index
    @categories = Category.all(limit: 2)
  end
  def show
    @category = Category.find_by_slug(params[:slug])
    @category.nil? redirect_to(categories) : render :show
  end
end
