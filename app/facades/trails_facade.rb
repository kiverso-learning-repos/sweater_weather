class TrailsFacade < ForecastFacade
  attr_reader :id, :location, :forecast, :trails
  def initialize(location)
    start_location = get_location(location)
    forecast = get_forecast(start_location)
    @id = 'null'
    @location = "#{start_location.city}, #{start_location.state}"
    # @forecast = format_current_forecast(forecast)
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
end