class Api::V1::BackgroundsController < ApplicationController
  def index
    location_data = MapService.new.location(params[:location])
    location = Location.new(location_data)
    forecast_data = WeatherService.new.forecast(location.latitude, location.longitude)
    forecast = Forecast.new(forecast_data)
    image_data = ImageService.new.background(forecast.current[:weather][0][:description])
    render json: BackgroundSerializer.new(Background.new(image_data[:results][0]))
  end

end
