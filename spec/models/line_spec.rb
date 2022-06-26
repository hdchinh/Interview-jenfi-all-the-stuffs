require "rails_helper"

RSpec.describe Line, type: :model do
  subject(:line) { build(:line) }

  describe "validations" do
    it "validates presence of name" do
      expect(line).to validate_presence_of(:name)
    end

    it "validates uniquess of name" do
      expect(line).to validate_uniqueness_of(:name)
    end
  end

  describe ".activated" do
    before do
      create(:line, blocked: false)
      create(:line, blocked: true)
    end

    it "returns active line only" do
      expect(Line.activated.map(&:blocked).uniq).to eq([false])
    end
  end
end
