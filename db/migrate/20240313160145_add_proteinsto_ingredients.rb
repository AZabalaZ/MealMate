class AddProteinstoIngredients < ActiveRecord::Migration[7.1]
  def change
    add_column :ingredients, :proteins, :integer
  end
end
