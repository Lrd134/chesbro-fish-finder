class CategoriesController < ApplicationController

  def index
    @categories = Category.all(limit: 2)
  end
  def show
  end
end
