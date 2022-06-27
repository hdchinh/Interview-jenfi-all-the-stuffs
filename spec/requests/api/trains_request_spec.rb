require "rails_helper"

RSpec.describe "Trains", type: :request do
  describe "POST /api/trains" do
    let(:headers) { { "Accept" => "application/json" } }
    let(:url) { "/api/trains" }
    let(:line) { create(:line) }
    let(:params) { { max_weight: 100, max_volume: 3, cost: 100, lines: [line.name] } }

    context "when request is missing train_operator api_key" do
      before { post url, params: params, headers: headers }

      it "returns :bad_request" do
        expect(response).to have_http_status(:bad_request)
      end
    end

    context "when request has a valid train_operator api_key" do
      let(:train_operator) { create(:train_operator) }
      let(:headers) { { "Accept" => "application/json", :"Authorization" => train_operator.api_key } }

      it "returns :ok" do
        post url, params: params, headers: headers
        expect(response).to have_http_status(:ok)
      end

      it "creates train information" do
        expect { post url, params: params, headers: headers }.to change(Train, :count).by(1)
      end
    end
  end

  describe "GET /api/trains" do
    let(:headers) { { "Accept" => "application/json" } }
    let(:url) { "/api/trains" }

    context "when request is missing train_operator api_key" do
      before { get url, params: {}, headers: headers }

      it "returns :bad_request" do
        expect(response).to have_http_status(:bad_request)
      end
    end

    context "when request has a valid train_operator api_key" do
      let(:train_operator) { create(:train_operator) }
      let(:headers) { { "Accept" => "application/json", :"Authorization" => train_operator.api_key } }

      it "returns :ok" do
        get url, params: {}, headers: headers
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET /api/trains/:id/status" do
    let(:headers) { { "Accept" => "application/json" } }
    let(:line) { create(:line) }
    let(:train_operator) { create(:train_operator) }
    let(:train) { create(:train, train_operator: train_operator, lines: [line.name]) }
    let(:url) { "/api/trains/#{train.id}/status" }

    context "when request is missing train_operator api_key" do
      before { get url, params: {}, headers: headers }

      it "returns :bad_request" do
        expect(response).to have_http_status(:bad_request)
      end
    end

    context "when request has a valid train_operator api_key" do
      let(:headers) { { "Accept" => "application/json", :"Authorization" => train_operator.api_key } }

      it "returns :ok" do
        get url, params: {}, headers: headers
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "PUT /api/trains/:id/withdraw" do
    let(:headers) { { "Accept" => "application/json" } }
    let(:line) { create(:line) }
    let(:train_operator) { create(:train_operator) }
    let(:train) { create(:train, train_operator: train_operator, lines: [line.name]) }
    let(:url) { "/api/trains/#{train.id}/withdraw" }

    context "when request is missing train_operator api_key" do
      before { put url, params: {}, headers: headers }

      it "returns :bad_request" do
        expect(response).to have_http_status(:bad_request)
      end
    end

    context "when request has a valid train_operator api_key" do
      let(:headers) { { "Accept" => "application/json", :"Authorization" => train_operator.api_key } }

      it "returns :ok" do
        put url, params: {}, headers: headers
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
