require "rails_helper"

RSpec.describe FillPackagesService do
  subject(:fill_packages_service) { described_class.new(line, train, Package.where(id: [package.id])) }

  let!(:line) { create(:line) }
  let!(:train) { create(:train, lines: [line.name]) }
  let!(:package) { create(:package, volume: 100_000, weight: 100, line_id: line.id) }

  describe "#perform" do
    context "when the train can carry all the packages" do
      it "updates the train status to unavailable" do
        fill_packages_service.perform
        expect(train.reload.unavailable?).to be true
      end

      it "updates the line status to unavailable" do
        fill_packages_service.perform
        expect(line.reload.unavailable?).to be true
      end

      it "updates the status of the packages" do
        fill_packages_service.perform
        expect(package.reload.in_progress?).to be true
      end
    end

    context "when the train cannot carry all the packages" do
      let!(:package_2) { create(:package, volume: 100_000, weight: 20, line_id: line.id) }

      it "updates the train status to unavailable" do
        fill_packages_service.perform
        expect(train.reload.unavailable?).to be true
      end

      it "updates the line status to unavailable" do
        fill_packages_service.perform
        expect(line.reload.unavailable?).to be true
      end

      it "updates the status of the packages" do
        fill_packages_service.perform
        expect(package.reload.in_progress?).to be true
      end

      it "does not update the status of the package that cannot be sent at that time" do
        fill_packages_service.perform
        expect(package_2.reload.in_progress?).to be false
      end
    end
  end
end
