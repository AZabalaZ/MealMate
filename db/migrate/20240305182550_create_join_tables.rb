class CreateJoinTables < ActiveRecord::Migration[7.1]
  def change
    create_table :join_tables do |t|
      t.references :meals, null: false, foreign_key: true
      t.references :ingredients, null: false, foreign_key: true

      t.timestamps
    end
  end
end
