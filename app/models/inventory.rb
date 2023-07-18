class Inventory < ApplicationRecord
  belongs_to :users
  has_many :inventory_foods, dependent: :destroy
  has_many :foods, through: :inventory_foods
end
