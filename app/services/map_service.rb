class MapService < GeneralService

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