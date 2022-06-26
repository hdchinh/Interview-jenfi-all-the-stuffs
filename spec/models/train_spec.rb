require "rails_helper"

RSpec.describe Train, type: :model do
  subject(:train) { build(:train) }

  describe "associations" do
    it { is_expected.to belong_to(:train_operator) }
  end

  describe "validations" do
    it "validates presence of max_weight" do
      expect(train).to validate_presence_of(:max_weight)
    end

    it "validates presence of max_volume" do
      expect(train).to validate_presence_of(:max_volume)
    end

    it "validates presence of cost" do
      expect(train).to validate_presence_of(:cost)
    end

    it "validates min weight" do
      expect(train).to validate_numericality_of(:max_weight).is_greater_than_or_equal_to(1)
    end

    it "validates min volume" do
      expect(train).to validate_numericality_of(:max_volume).is_greater_than_or_equal_to(1)
    end
  end

  describe ".activated" do
    before do
      create(:line)
      create(:train, active: false, lines: [Line.last.name])
      create(:train, active: true, lines: [Line.last.name])
    end

    it "returns active trains only" do
      expect(Train.activated.map(&:active).uniq).to eq([true])
    end
  end
end
