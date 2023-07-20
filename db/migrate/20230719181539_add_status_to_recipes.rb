class AddStatusToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :status, :string
  end
end
