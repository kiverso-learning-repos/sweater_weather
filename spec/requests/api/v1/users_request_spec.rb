require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do

  describe "post /create" do
    it "returns http success" do
      request_params = {
              email: "whatever@example.com",
              password: "password",
              password_confirmation: "password"
              }

      post "/api/v1/users", params: request_params.to_json, headers: { "Content-Type": "application/json" }
      expect(response).to have_http_status(:success)
                      
      user = JSON.parse(response.body, symbolize_names: true)
                        
      expect(user[:data][:attributes][:email]).to eq('whatever@example.com')
      expect(user[:data][:attributes][:api_key]).to_not be_nil
    end

    it "will not create user if password does not match" do
      request_params = {
              email: "whatever@example.com",
              password: "password1",
              password_confirmation: "password"
              }

      post "/api/v1/users", params: request_params.to_json, headers: { "Content-Type": "application/json" }
      expect(response).to have_http_status(:bad_request)
                      
      errors = JSON.parse(response.body, symbolize_names: true)
                        
      expect(errors[:errors].count).to eq(1)
      expect(errors[:errors].first).to eq("Password confirmation doesn't match Password")
    end

    it "will not create user if password is not present" do
      request_params = {
              email: "whatever@example.com",
              }

      post "/api/v1/users", params: request_params.to_json, headers: { "Content-Type": "application/json" }
      expect(response).to have_http_status(:bad_request)
                      
      errors = JSON.parse(response.body, symbolize_names: true)
                        
      expect(errors[:errors].count).to eq(1)
      expect(errors[:errors].first).to eq("Password can't be blank")
    end

    it "will not create user if email is not present" do
      request_params = {
              password: "password",
              password_confirmation: "password",
              }

      post "/api/v1/users", params: request_params.to_json, headers: { "Content-Type": "application/json" }
      expect(response).to have_http_status(:bad_request)
                      
      errors = JSON.parse(response.body, symbolize_names: true)
      expect(errors[:errors].count).to eq(1)
      expect(errors[:errors].first).to eq("Email can't be blank")
    end

    it "will not create a user if email is already taken" do
      request_params = {
              email: "whatever@example.com",
              password: "password",
              password_confirmation: "password"
              }
      user = User.create({
              email: "whatever@example.com",
              password: "password",
              password_confirmation: "password"
              })
              
      post "/api/v1/users", params: request_params.to_json, headers: { "Content-Type": "application/json" }
      expect(response).to have_http_status(:bad_request)
                      
      errors = JSON.parse(response.body, symbolize_names: true)
      
      expect(errors[:errors].count).to eq(1)
      expect(errors[:errors].first).to eq('Email has already been taken')
    end

    it "will return multiple errors if multple validations fail" do
      request_params = {
              email: "whatever@example.com",
              password: "password1",
              password_confirmation: "password"
              }
      user = User.create({
              email: "whatever@example.com",
              password: "password",
              password_confirmation: "password"
              })
              
      post "/api/v1/users", params: request_params.to_json, headers: { "Content-Type": "application/json" }
      expect(response).to have_http_status(:bad_request)
                      
      errors = JSON.parse(response.body, symbolize_names: true)
      
      expect(errors[:errors].count).to eq(2)
      expect(errors[:errors].first).to eq('Email has already been taken')
      expect(errors[:errors].last).to eq("Password confirmation doesn't match Password")
    end
  end
end
