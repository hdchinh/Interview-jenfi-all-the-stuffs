require "rails_helper"

RSpec.describe Customer, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:packages).dependent(:destroy) }
  end

  describe "validations" do
    let(:customer) { build(:customer) }

    it "validates uniquess of api_key" do
      expect(customer).to validate_uniqueness_of(:api_key)
    end
  end

  describe "callbacks" do
    it { is_expected.to callback(:generate_api_key).before(:validation) }
  end
end
