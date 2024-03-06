class AddPortionAndPreparationTimeToMeals < ActiveRecord::Migration[7.1]
  def change
    add_column :meals, :portion, :integer
    add_column :meals, :preparation_time, :integer
  end
end
