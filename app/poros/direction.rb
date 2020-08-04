class Direction
  attr_reader :origin, :origin_location, :destination, :destination_location, :travel_time
  def initialize(directions_info)
    @origin = format_place_name(directions_info[:route][:locations][0])
    @origin_location = directions_info[:route][:locations][0][:latLng]
    @destination = format_place_name(directions_info[:route][:locations][1])
    @destination_location = directions_info[:route][:locations][0][:latLng]
    @travel_time = directions_info[:route][:time]
  end

  def format_place_name(location)
    "#{location[:adminArea5]}, #{location[:adminArea3]}"
  end
end