class Forecast
  attr_reader :timezone_offset, :current, :hourly, :daily
  def initialize(forecast_data)
    @timezone_offset = forecast_data[:timezone_offset]
    @current = forecast_data[:current]
    @hourly = forecast_data[:hourly]
    @daily = forecast_data[:daily]
  end
end