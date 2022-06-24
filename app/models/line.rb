class Line < ApplicationRecord
  validates :name, uniqueness: true, presence: true
end
