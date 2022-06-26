class Train < ApplicationRecord
  belongs_to :train_operator

  validates_with ValidLinesValidator

  scope :activated, -> { where(active: true) }

  validates :max_volume, :max_weight, :cost, presence: true
end
