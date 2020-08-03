class TrailService < GeneralService

  def trails(latitude, longitude)
    params = {lat: latitude,
              lon: longitude}
    get_json('/data/get-trails', params)
  end

  private
  def conn
    Faraday.new(url: 'https://www.hikingproject.com') do |f|
      f.params[:key] = ENV['hiking_project_key']
    end
  end
end