class AddFavoriteToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :favorite, :boolean, default: false
  end
end
