class AddIngredientsToMeals < ActiveRecord::Migration[7.1]
  def change
    add_column :meals, :ingredients, :string, array: true, default: []
  end
end
