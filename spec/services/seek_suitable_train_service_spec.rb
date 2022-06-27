require "rails_helper"

RSpec.describe SeekSuitableTrainService do
  subject(:seek_suitable_train_service) { described_class.new(total_weight, total_volume, line) }

  let!(:total_weight) { 100 }
  let!(:total_volume) { 1 }
  let!(:line) { create(:line) }

  describe "#perform" do
    context "when system does not have any trains that can deliver in this line" do
      it "returns false" do
        expect(seek_suitable_train_service.perform).to be false
      end
    end

    context "when system has trains that can deliver in this line" do
      context "when cannot find a suitable train for all packages to that line" do
        before do
          create(:train, lines: [line.name], max_weight: 200, max_volume: 1, cost: 100)
          create(:train, lines: [line.name], max_weight: 200, max_volume: 1, cost: 99)
        end

        it "picks the cheaper train" do
          expect(seek_suitable_train_service.perform.cost).to eq(99)
        end
      end

      context "when find a suitable train that can carry all packages to that line" do
        before do
          create(:train, lines: [line.name], max_weight: 80, max_volume: 1, cost: 100)
          create(:train, lines: [line.name], max_weight: 50, max_volume: 1, cost: 99)
        end

        it "picks the biggest train" do
          expect(seek_suitable_train_service.perform.max_weight).to eq(80)
        end
      end
    end
  end
end
