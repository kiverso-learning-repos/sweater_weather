class TrailService < GeneralService

  def trails(latitude, longitude)
    params = {lat: latitude,
              lon: longitude}
    x = get_json('/data/get-trails', params)
    binding.pry
  end

  private
  def conn
    Faraday.new(url: 'https://www.hikingproject.com') do |f|
      f.params[:key] = ENV['hiking_project_key']
    end
  end
end