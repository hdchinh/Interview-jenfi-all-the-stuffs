require "rails_helper"

RSpec.describe Package, type: :model do
  let(:line) { build(:line) }
  subject(:package) { build(:package, line_id: line.id) }

  describe "validations" do
    it "validates presence of weight" do
      expect(package).to validate_presence_of(:weight)
    end

    it "validates presence of volume" do
      expect(package).to validate_presence_of(:volume)
    end

    it "validates min weight" do
      expect(package).to validate_numericality_of(:weight).is_greater_than_or_equal_to(1)
    end

    it "validates min volume" do
      expect(package).to validate_numericality_of(:volume).is_greater_than_or_equal_to(1)
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:customer) }
  end
end
