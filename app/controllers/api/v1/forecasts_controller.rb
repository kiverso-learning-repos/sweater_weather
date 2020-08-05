class Api::V1::ForecastsController < ApplicationController
  def show
    if params[:location].present?
      forecast = ForecastFacade.new(forecast_params[:location])
      render json: ForecastSerializer.new(forecast)
    else
      render json: {errors: ['Location is required.']}, status: :bad_request
    end
  end

  private
  def forecast_params
    params.permit(:location)
  end
end
