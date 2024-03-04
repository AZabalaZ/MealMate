class Recipe < ApplicationRecord
  belongs_to :users
  belongs_to :meals
end
