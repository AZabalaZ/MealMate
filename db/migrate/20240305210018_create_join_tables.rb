class CreateJoinTables < ActiveRecord::Migration[7.1]
  def change
    create_table :join_tables do |t|
      t.references :meal, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
