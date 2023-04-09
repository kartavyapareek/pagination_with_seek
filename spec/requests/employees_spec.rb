require 'rails_helper'

RSpec.describe "Employees", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/employees"
      expect(response).to have_http_status(:success)
    end
  end

end
