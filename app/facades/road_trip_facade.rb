class RoadTripFacade
  attr_reader :id, :origin, :destination, :travel_time, :arrival_forecast

  def initialize(origin, destination)
    directions = get_directions(origin, destination)
  end

  def get_directions(origin, destination)
    map_service = MapService.new
    location_data = map_service.directions(origin, destination)
    Direction.new(location_data)
  end
end