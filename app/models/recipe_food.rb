class RecipeFood < ApplicationRecord
  belongs_to :recipes
  belongs_to :foods

  validates :quantity, presence: true
end
