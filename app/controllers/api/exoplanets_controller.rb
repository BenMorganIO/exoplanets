module Api
  class ExoplanetsController < ApplicationController
    def index
      render json: exoplanets
    end

    private

    def exoplanets
      if params[:ids]
        exoplanets = Exoplanet.where(id: params[:ids].split(",").flatten)
      else
        exoplanets = Exoplanet.all
      end

      exoplanets = exoplanets.page(params[:page]).per(params[:per_page]) if params[:page]
      exoplanets.order(:id)
    end
  end
end
