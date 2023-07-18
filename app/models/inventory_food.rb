class InventoryFood < ApplicationRecord
  belongs_to :food
  belongs_to :inventory

  validates :quantity, presence: true
  validates :food_id, presence: true
  validates :inventory_id, presence: true
  validates :quantity_unit, presence: true
end
