class Location
  attr_reader :city, :state, :latitude, :longitude
  def initialize(location_data)
    location = location_data[:results][0][:locations][0]
    @city = location[:adminArea5]
    @state = location[:adminArea3]
    @latitude = location[:latLng][:lat]
    @longitude = location[:latLng][:lng]
  end
end