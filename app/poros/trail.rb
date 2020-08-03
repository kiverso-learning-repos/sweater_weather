class Trail
  attr_reader :name, :summary, :difficulty, :location, :distance_to_trail

  def initialize(trail_info, start_location)
    @name = trail_info[:name]
    @summary = trail_info[:summary]
    @difficulty = trail_info[:difficulty]
    @location = trail_info[:location]
    @distance_to_trail = get_distance(trail_info, start_location)
  end

  def get_distance(trail, start_location)
    trail_latlng = "#{trail[:latitude]},#{trail[:longitude]}"
    map_service = MapService.new
    directions = map_service.directions(start_location, trail_latlng)
    directions[:route][:distance]
  end
end