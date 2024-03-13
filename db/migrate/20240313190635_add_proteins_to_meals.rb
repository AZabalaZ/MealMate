class AddProteinsToMeals < ActiveRecord::Migration[7.1]
  def change
    add_column :meals, :proteins, :integer
  end
end
