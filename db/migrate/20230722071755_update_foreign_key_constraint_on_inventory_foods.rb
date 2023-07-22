class UpdateForeignKeyConstraintOnInventoryFoods < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :inventory_foods, :inventories
    add_foreign_key :inventory_foods, :inventories, on_delete: :cascade
  end
end
