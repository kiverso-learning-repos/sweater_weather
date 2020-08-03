class Background
  attr_reader :id, :url

  def initialize(image_data)
    @id = image_data[:id]
    @url = image_data[:urls][:full]
  end
end