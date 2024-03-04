class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.references :users, null: false, foreign_key: true
      t.references :meals, null: false, foreign_key: true

      t.timestamps
    end
  end
end
