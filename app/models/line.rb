class Line < ApplicationRecord
  validates :name, uniqueness: true, presence: true

  scope :activated, -> { where(blocked: false) }
end
