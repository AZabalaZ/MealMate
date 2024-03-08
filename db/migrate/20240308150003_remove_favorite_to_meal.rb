class RemoveFavoriteToMeal < ActiveRecord::Migration[7.1]
  def change
    remove_column :meals, :favorite, :boolean
  end
end
