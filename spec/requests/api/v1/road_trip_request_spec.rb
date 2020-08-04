require 'rails_helper'

RSpec.describe "Api::V1::RoadTrips", type: :request do

  describe "post road_trip" do
    before(:each) do
      @user = User.create({
              email: "whatever@example.com",
              password: "password",
              password_confirmation: "password"
              })
    end

    it "returns http success" do
      request_params = { 
              email: "whatever@example.com",
              password: "password"
              }

      post "/api/v1/road_trip", params: request_params.to_json, headers: { "Content-Type": "application/json" }
      expect(response).to have_http_status(:success)

      road_trip = JSON.parse(response.body, symbolize_names: true)

      expect(forecast[:data][:attributes][:origin]).to eq('Denver, CO')
      expect(forecast[:data][:attributes][:destination]).to eq('Pueblo, CO')

      expect(forecast[:data][:attributes][:travel_time]).to_not be_nil
      expect(forecast[:data][:attributes][:arrival_forecast][:temp]).to_not be_nil
      expect(forecast[:data][:attributes][:arrival_forecast][:summary]).to_not be_nil
    end
  end

end
