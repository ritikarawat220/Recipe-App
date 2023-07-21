require 'rails_helper'
RSpec.describe RecipeFood, type: :model do
  describe 'associations' do
    it 'belongs to recipe' do
      association = described_class.reflect_on_association(:recipe)
      expect(association.macro).to eq(:belongs_to)
    end
    it 'belongs to food' do
      association = described_class.reflect_on_association(:food)
      expect(association.macro).to eq(:belongs_to)
    end
  end
  describe 'validations' do
    it 'validates presence of quantity' do
      recipe_food = RecipeFood.new(quantity: nil)
      expect(recipe_food.valid?).to be_falsey
      expect(recipe_food.errors[:quantity]).to include("can't be blank")
    end
  end
end
