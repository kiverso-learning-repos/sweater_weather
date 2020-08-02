class MapService < GeneralService

  def location(location_param)
    params = {location: location_param}
    x = get_json('/geocoding/v1/address', params)
    binding.pry
  end

  private
  def conn
    Faraday.new(url: 'http://www.mapquestapi.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['mapquest_key']
    end
  end
end