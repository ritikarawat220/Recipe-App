class CreateInventoryFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :inventory_foods do |t|
      t.decimal :quantity
      t.references :foods, null: false, foreign_key: true
      t.references :inventories, null: false, foreign_key: true

      t.timestamps
    end
  end
end
