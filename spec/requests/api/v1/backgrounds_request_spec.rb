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

    it "returns errors when no location param is submitted" do
      request_params = {}
      get '/api/v1/backgrounds', params: request_params
      expect(response).to have_http_status(:bad_request)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors[:errors].length).to eq(1)
      expect(errors[:errors].first).to eq('Location is required.')
    end
  end
end
