require 'rails_helper'

RSpec.describe "Api::V1::Forecasts", type: :request do

  describe "GET /forecast" do
    it "returns http success", :vcr do
      request_params = {location: 'denver,co'}
      get '/api/v1/forecast', params: request_params
      expect(response).to have_http_status(:success)
      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(forecast[:data][:attributes][:city]).to eq('Denver')
      expect(forecast[:data][:attributes][:state]).to eq('CO')

      expect(forecast[:data][:attributes][:current_weather][:temp]).to_not be_nil
      expect(forecast[:data][:attributes][:current_weather][:sunrise]).to_not be_nil
      expect(forecast[:data][:attributes][:current_weather][:sunset]).to_not be_nil
      expect(forecast[:data][:attributes][:current_weather][:weather]).to_not be_nil
      expect(forecast[:data][:attributes][:current_weather][:uvi]).to_not be_nil
      expect(forecast[:data][:attributes][:current_weather][:humidity]).to_not be_nil
      expect(forecast[:data][:attributes][:current_weather][:visibility]).to_not be_nil
      expect(forecast[:data][:attributes][:current_weather][:feels_like]).to_not be_nil

      forecast[:data][:attributes][:hourly_forecast].each do |hour|
        expect(hour[:time]).to_not be_nil
        expect(hour[:temp]).to_not be_nil
        expect(hour[:weather]).to_not be_nil
      end

      forecast[:data][:attributes][:daily_forecast].each do |day|
        expect(day[:time]).to_not be_nil
        expect(day[:temp]).to_not be_nil
        expect(day[:weather]).to_not be_nil
        expect(day[:precipitation]).to_not be_nil
      end
    end

    it "returns errors when no location param is submitted" do
      request_params = {}
      get '/api/v1/forecast', params: request_params
      expect(response).to have_http_status(:bad_request)
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors[:errors].length).to eq(1)
      expect(errors[:errors].first).to eq('Location is required.')
    end
  end
end
