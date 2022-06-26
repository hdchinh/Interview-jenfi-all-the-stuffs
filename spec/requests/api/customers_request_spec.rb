require "rails_helper"

RSpec.describe "Customers", type: :request do
  describe "GET /api/customers" do
    let(:url) { "/api/customers" }
    let(:params) { { name: "naruto" } }

    it "returns :ok" do
      post url, params: params, headers: { "Accept" => "application/json" }
      expect(response).to have_http_status(:ok)
    end

    it "creates customer" do
      expect { post url, params: params, headers: { "Accept" => "application/json" } }.to change(Customer, :count).by(1)
    end
  end
end
