class FishController < ApplicationController
  before_action :set_fish, only: %i[ show edit update destroy ]

  private
    
    def set_fish
      @fish = Fish.find(params[:id])
    end

    def fish_params
      params.fetch(:fish, {})
    end
end
