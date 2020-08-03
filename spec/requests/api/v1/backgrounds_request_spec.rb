require 'rails_helper'

RSpec.describe "Api::V1::Backgrounds", type: :request do

  describe "GET /index" do
    it "returns http success", :vcr do
      request_params = {location: 'denver,co'}
      get "/api/v1/backgrounds", params: request_params
      expect(response).to have_http_status(:success)
      background = JSON.parse(response.body, symbolize_names: true)
      expect(background[:data][:attributes][:id]).to_not be_nil
      expect(background[:data][:attributes][:url]).to_not be_nil
    end
  end

end
