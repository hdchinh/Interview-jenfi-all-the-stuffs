require "rails_helper"

RSpec.describe "Packages", type: :request do
  describe "POST /api/packages" do
    let(:url) { "/api/packages" }
    let(:headers) { { "Accept" => "application/json" } }
    let(:line) { create(:line) }
    let(:params) { { weight: 100, volume: 1000, line: line.name } }

    context "when request is missing customer api_key" do
      before { post url, params: params, headers: headers }

      it "returns :not_found" do
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when request has a valid customer api_key" do
      let(:customer) { create(:customer) }
      let(:headers) { { "Accept" => "application/json", :"Authorization" => customer.api_key } }

      it "returns :ok" do
        post url, params: params, headers: headers
        expect(response).to have_http_status(:ok)
      end

      it "creates package information" do
        expect { post url, params: params, headers: headers }.to change(Package, :count).by(1)
      end
    end
  end

  describe "GET /api/packages/:id/status" do
    let(:headers) { { "Accept" => "application/json" } }
    let(:line) { create(:line) }
    let(:customer) { create(:customer) }
    let(:package) { create(:package, line_id: line.id, customer: customer) }
    let(:url) { "/api/packages/#{package.id}/status" }

    context "when request is missing customer api_key" do
      before { get url, params: {}, headers: headers }

      it "returns :not_found" do
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when request has a valid customer api_key" do
      let(:headers) { { "Accept" => "application/json", :"Authorization" => customer.api_key } }

      it "returns :ok" do
        get url, params: {}, headers: headers
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "PUT /api/packages/:id/withdraw" do
    let(:headers) { { "Accept" => "application/json" } }
    let(:line) { create(:line) }
    let(:customer) { create(:customer) }
    let!(:package) { create(:package, line_id: line.id, customer: customer, status: Package.statuses[:pending]) }
    let(:url) { "/api/packages/#{package.id}/withdraw" }

    context "when request is missing customer api_key" do
      before { put url, params: {}, headers: headers }

      it "returns :not_found" do
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when request has a valid customer api_key" do
      let(:headers) { { "Accept" => "application/json", :"Authorization" => customer.api_key } }

      context "when customer is trying to withdraw a package that has not status is pending" do
        let!(:package) { create(:package, line_id: line.id, customer: customer, status: Package.statuses[:completed]) }

        before { put url, params: {}, headers: headers }

        it "returns :bad_request" do
          expect(response).to have_http_status(:bad_request)
        end

        it "does not update status" do
          expect(package.reload.completed?).to be true
        end
      end

      context "when customer is trying to withdraw a package that has status is pending" do
        before { put url, params: {}, headers: headers }

        it "returns :ok" do
          expect(response).to have_http_status(:ok)
        end

        it "updates status to withdraw" do
          expect(package.reload.withdraw?).to be true
        end
      end
    end
  end
end
