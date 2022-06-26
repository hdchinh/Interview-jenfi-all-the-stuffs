class TrainOperator < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  validates :api_key, uniqueness: true, presence: true

  has_many :trains, dependent: :destroy

  before_validation :generate_api_key

  def generate_api_key
    return if self.api_key.present?

    self.api_key = "TO-#{rand.to_s[2..5]}"
  end
end
