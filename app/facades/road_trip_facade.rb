class RoadTripFacade < ForecastFacade
  attr_reader :id, :origin, :destination, :travel_time, :arrival_forecast

  def initialize(origin, destination)
    directions = get_directions(origin, destination)
    forecast = get_forecast(directions.destination_location[:lat], directions.destination_location[:lng])
    @id = 'null'
    @origin = directions.origin
    @destination = directions.destination
    @destination = directions.travel_time
    @arrival_forecast = format_forcast(forecast)
  end

  def get_directions(origin, destination)
    map_service = MapService.new
    location_data = map_service.directions(origin, destination)
    Direction.new(location_data)
  end

  def format_forecast(forecast)
    {summary: forecast.current[:weather][0][:description],
     temperature: forecast.current[:temp]}
  end
end