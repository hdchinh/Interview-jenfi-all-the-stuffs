class Line < ApplicationRecord
  validates :name, uniqueness: true, presence: true

  enum status: { available: 0, unavailable: 1 }

  scope :activated, -> { where(blocked: false) }
end
