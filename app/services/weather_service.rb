class WeatherService < GeneralService

  def forecast(latitude, longitude)
    params = {lat: latitude,
              lon: longitude,
              units: 'imperial',
              exclude: 'minutely'}
    get_json('/data/2.5/onecall', params)
  end

  private
  def conn
    Faraday.new(url: 'https://api.openweathermap.org') do |f|
      f.params[:appid] = ENV['openweather_key']
    end
  end
end