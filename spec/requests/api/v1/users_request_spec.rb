require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do

  describe "post /create" do
    it "returns http success" do
      request_params = {
                        email: "whatever@example.com",
                        password: "password",
                        password_confirmation: "password"
                        }
      post "/api/v1/users", params: request_params
      expect(response).to have_http_status(:success)
                      
      user = JSON.parse(response.body, symbolize_names: true)
                        
      expect(user[:data][:attributes][:email]).to eq('whatever@example.com')
      expect(user[:data][:attributes][:api_key]).to_not be_nil
    end
  end
end
