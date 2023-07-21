class RecipeFood < ApplicationRecord
  belongs_to :recipe, foreign_key: 'recipe_id' # Update the foreign key for the 'recipe' association
  belongs_to :food, foreign_key: 'food_id' # Update the foreign key for the 'food' association

  validates :quantity, presence: true
end
