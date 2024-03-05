class AddImageUrlToMeals < ActiveRecord::Migration[7.1]
  def change
    add_column :meals, :image_url, :string
  end
end
