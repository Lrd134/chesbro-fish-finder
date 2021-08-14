class FishController < ApplicationController
  before_action :set_fish, only: %i[ show edit update destroy ]
  def index
    @fish = Fish.all
  end
  private
    
    def set_fish
      @fish = Fish.find_by_slug(params[:fish_slug])
    end

    def fish_params
      params.fetch(:fish, {})
    end
end
