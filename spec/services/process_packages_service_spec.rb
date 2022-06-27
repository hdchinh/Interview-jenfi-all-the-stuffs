require "rails_helper"

RSpec.describe ProcessPackagesService do
  subject(:process_packages_service) { described_class.new(line) }

  let!(:line) { create(:line) }
  let!(:train) { create(:train, lines: [line.name]) }
  let!(:package) { create(:package, line_id: line.id) }

  describe "#perform" do
    let(:seek_suitable_train_service) { spy }
    let(:fill_packages_service) { spy }

    context "when has packages that are pending" do
      context "when cannot find a train" do
        before do
          Train.destroy_all
          create(:train, lines: [line.name], status: Line.statuses[:unavailable])
        end

        it "returns false" do
          expect(process_packages_service.perform).to be false
        end
      end

      context "when finds a train" do
        before do
          create(:train, lines: [line.name], status: Line.statuses[:available])

          allow(SeekSuitableTrainService).to receive(:new).and_return(seek_suitable_train_service)
          allow(FillPackagesService).to receive(:new).and_return(fill_packages_service)
        end

        it "calls SeekSuitableTrainService" do
          process_packages_service.perform
          expect(seek_suitable_train_service).to have_received(:perform).once
        end

        it "calls FillPackagesService" do
          process_packages_service.perform
          expect(fill_packages_service).to have_received(:perform).once
        end
      end
    end

    context "when does not have packages that are pending" do
      before { Package.destroy_all }

      it "returns false" do
        expect(process_packages_service.perform).to be false
      end
    end
  end
end
