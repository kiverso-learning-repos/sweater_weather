class ForecastFacade
  attr_reader :city, :state, :current_weather, :hourly_forecast, :daily_forecast
  def initialize(location)
    forecast_location = get_location(location)
    forecast = get_forecast(forecast_location)
    @city = forecast_location.city
    @state = forecast_location.state
    @current_weather = format_current_weather(forecast.current)
    @hourly_forecast = format_hourly_forecast(forecast.hourly)
    @daily_forecast = format_daily_forecast(forecast.daily)
    binding.pry
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

  def format_current_weather(current)
    current[:sunrise] = Time.at(current[:sunrise]).strftime('%l:%M %p')
    current[:sunset] = Time.at(current[:sunset]).strftime('%l:%M %p')
    current[:visibility] = (current[:visibility] / 1609).to_f
    current
  end

  def format_hourly_forecast(hourly)
    hourly.map do |hour|
      {time: Time.at(hour[:dt]).strftime('%l %p'),
       temp: hour[:temp],
       weather: hour[:weather]
      }
    end
  end

  def format_daily_forecast(daily)
    daily.map do |day|
      if day[:rain]
        precipitation = day[:rain]
      else
        precipitation = 0
      end
      {day: Time.at(day[:dt]).strftime('%A'),
       temp: day[:temp],
       weather: day[:weather],
       precipitation: precipitation
      }
    end
  end


end