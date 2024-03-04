class CreateMeals < ActiveRecord::Migration[7.1]
  def change
    create_table :meals do |t|
      t.string :name
      t.string :description
      t.integer :calories
      t.boolean :favorite

      t.timestamps
    end
  end
end
