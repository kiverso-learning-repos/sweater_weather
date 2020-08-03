class ImageService < GeneralService

  def background(search_param)
    params = {query: search_param_param}
    get_json('/search/photos', params)
  end

  private
  def conn
    Faraday.new(url: 'https://api.unsplash.com') do |f|
      f.params[:client_id] = ENV['unsplash_key']
    end
  end
end