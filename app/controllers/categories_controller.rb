class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end
  def show
    @category = Category.find_by_slug(params[:cat_slug])
    @category.nil? ? redirect_to(categories_path) : render(:show) unless params[:cat_slug] == "new" || params[:cat_slug] == "edit"
    redirect_to 
  end
end
