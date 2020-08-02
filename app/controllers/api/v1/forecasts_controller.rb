class Api::V1::ForecastsController < ApplicationController
  def show
    forecast = ForecastFacade.new(forecast_params[:location])
  end

  private
  def forecast_params
    params.permit(:location)
  end
end
