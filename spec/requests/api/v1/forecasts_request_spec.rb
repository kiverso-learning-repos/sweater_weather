require 'rails_helper'

RSpec.describe "Api::V1::Forecasts", type: :request do

  describe "GET /forecast" do
    it "returns http success" do
      request_params = {location: 'denver,co'}
      get '/api/v1/forecast', params: request_params
      expect(response).to have_http_status(:success)
      binding.pry
      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(forecast[:data][:location][:name]).to eq('Denver, CO')
      # expect(forecast[:data][:weather][:current])
    end
  end
end
