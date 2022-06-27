class Train < ApplicationRecord
  belongs_to :train_operator

  validates :max_volume, :max_weight, :cost, presence: true
  validates :max_volume, :max_weight, :cost, numericality: { greater_than_or_equal_to: 1 }
  validates_with ValidLinesValidator

  enum status: { available: 0, unavailable: 1 }

  scope :activated, -> { where(active: true) }
end
