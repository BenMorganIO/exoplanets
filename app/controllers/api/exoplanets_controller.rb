module Api
  class ExoplanetsController < ApplicationController
    def index
      render json: Exoplanet.all
    end
  end
end
