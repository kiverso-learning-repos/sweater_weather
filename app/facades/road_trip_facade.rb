class RoadTripFacade < ForecastFacade
  attr_reader :id, :origin, :destination, :travel_time, :arrival_forecast

  def initialize(origin, destination)
    directions = get_directions(origin, destination)
    forecast = get_forecast(directions.destination_location[:lat], directions.destination_location[:lng])
    @id = 'null'
    @origin = directions.origin
    @destination = directions.destination
    @travel_time = directions.travel_time
    @arrival_forecast = format_arrival_forecast(forecast)
  end

  def get_directions(origin, destination)
    map_service = MapService.new
    location_data = map_service.directions(origin, destination)
    Direction.new(location_data)
  end

  def format_arrival_forecast(forecast)
    hours = (@travel_time.to_f / 3600.00).round
    
    {summary: forecast.hourly[hours][:weather][0][:description],
     temperature: forecast.hourly[hours][:temp]}
  end
end