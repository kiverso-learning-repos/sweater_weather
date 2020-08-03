class TrailsFacade < ForecastFacade
  attr_reader :id, :location, :forecast, :trails
  
  def initialize(location)
    start_location = get_location(location)
    start_forecast = get_forecast(start_location)
    @id = 'null'
    @location = "#{start_location.city}, #{start_location.state}"
    @forecast = format_current_forecast(start_forecast)
    @trails = get_trails(start_location)
  end

 def get_trails(location)
  location_latlng = "#{location.latitude},#{location.longitude}"
    trail_service = TrailService.new
    trails_data = trail_service.trails(location.latitude, location.longitude)
    trails_data[:trails].map do |trail|
      Trail.new(trail, location_latlng)
    end
  end

  def format_current_forecast(forecast)
    {summary: forecast.current[:weather][0][:description],
     temperature: forecast.current[:temp]}
  end
end