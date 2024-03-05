class JoinTable < ApplicationRecord
  belongs_to :meals
  belongs_to :ingredients
end
