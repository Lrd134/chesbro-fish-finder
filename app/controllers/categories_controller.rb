class CategoriesController < ApplicationController

  def index
    @categories = Category.all(limit: 2)
  end
  def show
    @category = Category.find_by_slug(params[:slug])
    @category.nil? ridirect_to(categories)
  end
end
