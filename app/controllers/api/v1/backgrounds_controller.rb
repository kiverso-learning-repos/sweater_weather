class Api::V1::BackgroundsController < ApplicationController
  def index
    location_data = MapService.new.location(params[:location])
    location = Location.new(location_data)
    forecast_data = WeatherService.new.forecast(location.latitude, location.longitude)
    forecast = Forecast.new(forecast_data)
    binding.pry
    image_data = ImageService.new.background(forecast.current[:weather][0][:description])
    Background.new(image_data)
  end

end
