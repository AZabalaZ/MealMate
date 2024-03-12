class Meal < ApplicationRecord
  has_many :users
  validates :calories, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
