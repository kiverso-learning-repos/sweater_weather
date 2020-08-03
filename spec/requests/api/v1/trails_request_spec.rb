require 'rails_helper'

RSpec.describe "Api::V1::Trails", type: :request do

  describe "GET /trails" do
    it "returns http success" do
      request_params = {location: 'denver,co'}
      get "/api/v1/trails", params: request_params
      expect(response).to have_http_status(:success)

      trails = JSON.parse(response.body, symbolize_name: true)

      expect(trails[:data][:attributes][:location]).to eq("Denver, CO")
      expect(trails[:data][:attributes][:forecast][:summary]).to_not be_nil
      expect(trails[:data][:attributes][:forecast][:temp]).to_not be_nil
      trails[:data][:attributes][:trails].each do |trail|
        expect(trail[:name]).to_not be_nil
        expect(trail[:summary]).to_not be_nil
        expect(trail[:difficulty]).to_not be_nil
        expect(trail[:location]).to_not be_nil
        expect(trail[:distance_to_trail]).to_not be_nil
      end
    end
  end

end
