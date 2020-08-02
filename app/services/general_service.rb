class GeneralService

  def get_json(uri, params)
    response = conn.get(uri, params)
    JSON.parse(response.body, symbolize_names: true)
  end
end