class ForecastFacade
  attr_reader :id, :city, :state, :current_weather, :hourly_forecast, :daily_forecast, :timezone_offset
  def initialize(location)
    forecast_location = get_location(location)
    forecast = get_forecast(forecast_location)
    @id = SecureRandom.uuid
    @city = forecast_location.city
    @state = forecast_location.state
    @current_weather = forecast.current
    @hourly_forecast = format_hourly_forecast(forecast)
    @daily_forecast = format_daily_forecast(forecast)
    @timezone_offset = forecast.timezone_offset
  end

  private

  def get_location(location)
    map_service = MapService.new
    location_data = map_service.location(location)
    Location.new(location_data)
  end

  def get_forecast(location)
    weather_service = WeatherService.new
    forecast_data = weather_service.forecast(location.latitude, location.longitude)
    Forecast.new(forecast_data)
  end

  def format_hourly_forecast(forecast)
    hourly = forecast.hourly
    hourly.map do |hour|
      {time: hour[:dt],
       temp: hour[:temp],
       weather: hour[:weather]
      }
    end
  end

  def format_daily_forecast(forecast)
    forecast.daily.map do |day|
      if day[:rain]
        precipitation = day[:rain]
      else
        precipitation = 0
      end
      {time: day[:dt],
       temp: day[:temp],
       weather: day[:weather],
       precipitation: precipitation
      }
    end
  end


end