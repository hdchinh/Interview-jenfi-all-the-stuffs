class Customer < ApplicationRecord
  before_validation :generate_api_key

  validates :api_key, uniqueness: true, presence: true

  has_many :packages, dependent: :destroy

  def generate_api_key
    return if self.api_key.present?

    self.api_key = "U-#{rand.to_s[2..5]}"
  end
end
