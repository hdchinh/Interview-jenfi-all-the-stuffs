require "rails_helper"

RSpec.describe TrainOperator, type: :model do
  describe "callbacks" do
    it { is_expected.to callback(:generate_api_key).before(:validation) }
  end

  describe "associations" do
    it { is_expected.to have_many(:trains).dependent(:destroy) }
  end

  describe "validations" do
    let(:train_operator) { build(:train_operator) }

    it "validates uniquess of name" do
      expect(train_operator).to validate_uniqueness_of(:name)
    end

    it "validates presence of name" do
      expect(train_operator).to validate_presence_of(:name)
    end

    it "validates uniquess of api_key" do
      expect(train_operator).to validate_uniqueness_of(:api_key)
    end
  end
end
