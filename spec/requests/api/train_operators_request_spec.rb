require "rails_helper"

RSpec.describe "TrainOperators", type: :request do
  describe "GET /api/train_operators" do
    let(:url) { "/api/train_operators" }

    before { get url, headers: { "Accept" => "application/json" } }

    it "returns :ok" do
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /api/train_operators" do
    let(:headers) { { "Accept" => "application/json" } }
    let(:url) { "/api/train_operators" }
    let(:params) { { name: "Train Operator 1" } }

    it "returns :ok" do
      post url, params: params, headers: headers
      expect(response).to have_http_status(:ok)
    end

    it "creates train operator" do
      expect { post url, params: params, headers: headers }.to change(TrainOperator, :count).by(1)
    end
  end
end
