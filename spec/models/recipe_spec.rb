require 'rails_helper'
RSpec.describe 'Recipe', type: :model do
  before :each do
    @user = User.create(
      name: 'Test',
      email: 'test@example.com',
      password: 'password'
    )
    @recipe = Recipe.create(
      user: @user,
      name: 'Recipe 1',
      preparation_time: 1,
      cooking_time: 2,
      description: 'test test',
      public: true
    )
  end

  it 'Recipe model field should be equal to test recipe' do
    expect(@recipe.name).to eq 'Recipe 1'
    expect(@recipe.preparation_time).to eq 1
    expect(@recipe.cooking_time).to eq 2
    expect(@recipe.description).to eq 'test test'
  end
end
