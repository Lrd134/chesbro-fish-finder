class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end
  def show
    @category = Category.find_by_slug(params[:cat_slug])
    @category.nil? ? redirect_to(categories_path, notice: "Category not found") : render(:show)
  end
end
