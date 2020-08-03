class MapService < GeneralService

  def directions(start_location, end_location)
    params = {from: start_location,
              to: end_location}
    get_json('/directions/v2/route', params)
  end

  def location(location_param)
    params = {location: location_param}
    get_json('/geocoding/v1/address', params)
  end

  private
  def conn
    Faraday.new(url: 'http://www.mapquestapi.com') do |f|
      f.params[:key] = ENV['mapquest_key']
    end
  end
end