class AddCaloriesSumToMeals < ActiveRecord::Migration[7.1]
  def change
    add_column :meals, :calories_sum, :integer
  end
end
