require 'rails_helper'

RSpec.describe "Api::V1::Sessions", type: :request do

  describe "POST /sessions" do
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

      post "/api/v1/sessions", params: request_params.to_json, headers: { "Content-Type": "application/json" }
      expect(response).to have_http_status(:success)
                      
      session = JSON.parse(response.body, symbolize_names: true)
                        
      expect(session[:data][:type]).to eq('user')
      expect(session[:data][:id]).to eq(@user.id)
      expect(session[:data][:attributes][:email]).to eq(@user.email)
      expect(session[:data][:attributes][:api_key]).to eq(@user.api_key)
      expect(session[:data][:attributes][:password]).to be_nil
    end

    it "returns an error if email is not correct" do
      request_params = {
              email: "whatever1@example.com",
              password: "password"
              }

      post "/api/v1/sessions", params: request_params.to_json, headers: { "Content-Type": "application/json" }
      expect(response).to have_http_status(:success)
                                              
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors[:errors].count).to eq(1)
      expect(errors[:errors].first).to eq("Invalid email or password")
    end

    it "returns an error if email is not present" do
      request_params = {
              password: "password"
              }

      post "/api/v1/sessions", params: request_params.to_json, headers: { "Content-Type": "application/json" }
      expect(response).to have_http_status(:success)
                                              
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors[:errors].count).to eq(1)
      expect(errors[:errors].first).to eq("Invalid email or password")
    end

    it "returns an error if password is not correct" do
      request_params = {
              email: "whatever@example.com",
              password: "wrong_password"
              }

      post "/api/v1/sessions", params: request_params.to_json, headers: { "Content-Type": "application/json" }
      expect(response).to have_http_status(:success)
                                              
      errors = JSON.parse(response.body, symbolize_names: true)

      expect(errors[:errors].count).to eq(1)
      expect(errors[:errors].first).to eq("Invalid email or password")
    end
  end
end
