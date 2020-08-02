class ForecastSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :city, :state, :current_weather, :hourly_forecast, :daily_forecast, :timezone_offset
end
