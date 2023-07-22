class Inventory < ApplicationRecord
  belongs_to :user
  has_many :inventory_foods
  has_many :foods, through: :inventory_foods

  validates :name, presence: true
  validates :user_id, presence: true
  validates :description, presence: true
end
