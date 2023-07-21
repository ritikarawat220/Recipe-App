class Recipe < ApplicationRecord
  include Visible

  belongs_to :user
  has_many :recipe_foods, foreign_key: 'recipe_id' # Update the foreign key here
  has_many :foods, through: :recipe_foods

  validates :name, presence: true
  validates :cooking_time, presence: true
  validates :preparation_time, presence: true
  validates :description, presence: true
end
