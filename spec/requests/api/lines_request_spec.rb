require "rails_helper"

RSpec.describe "Lines", type: :request do
  describe "GET /api/lines" do
    let(:url) { "/api/lines" }

    before { get url, headers: { "Accept" => "application/json" } }

    it "returns :ok" do
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /api/lines/active" do
    let(:url) { "/api/lines/active" }

    before do
      create(:line, blocked: true)
      create(:line, blocked: false)

      get url, headers: { "Accept" => "application/json" }
    end

    it "returns :ok" do
      expect(response).to have_http_status(:ok)
    end

    it "returns active line only" do
      expect(json_response[:data].map { |line| line["blocked"] }.uniq).to eq([false])
    end
  end
end
