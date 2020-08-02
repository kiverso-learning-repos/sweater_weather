class ForecastFacade
  attr_reader :weather, :location
  def initialize(location)
    @location = get_location(location)
    @forecast = get_forecast
  end

  def get_location(location)
    map_service = MapService.new
    location_data = map_service.location(location)
    Location.new(location_data)
  end

  def get_forecast
    forecast_service = ForecastService.new
    forecast = forecast_service.forecast(@location.latitude, @location.longitude)
    Forecast.new(forecast)
  end
end