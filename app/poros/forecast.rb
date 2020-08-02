class Forecast
  attr_reader :current, :hourly, :daily
  def initialize(forecast_data)
    @current = forecast_data[:current]
    @hourly = forecast_data[:hourly]
    @daily = forecast_data[:daily]
  end
end