class Package < ApplicationRecord
  validates :volume, :weight, presence: true
  validates :volume, :weight, numericality: { greater_than_or_equal_to: 1 }
  validates_with PackageMaxSizeValidator

  enum status: { pending: 0, in_progress: 1, withdraw: 2, completed: 3 }

  belongs_to :customer
end
