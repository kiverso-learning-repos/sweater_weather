require 'rails_helper'

RSpec.describe "Api::V1::Backgrounds", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/backgrounds"
      expect(response).to have_http_status(:success)
    end
  end

end
