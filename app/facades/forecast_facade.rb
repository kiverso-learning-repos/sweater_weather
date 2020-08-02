class ForecastFacade
  attr_reader :weather, :location
  def initialize(location)
    @location = get_location(location)
  end

  def get_location(location)
    map_service = MapService.new
    location_data = map_service.location(location)
    location = Location.new(location_data)
  end
end