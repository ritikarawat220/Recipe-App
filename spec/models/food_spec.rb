require 'rails_helper'
RSpec.describe Food, type: :model do
  before :each do
    @food = Food.create(name: 'kheer', measurement_unit: 3, price: 1, unit_quantity: 'kgs')
  end
  it 'should have a name' do
    food = @food.name
    expect(food).to eq('kheer')
  end

  it 'should contain the measurement' do
    expect(@food.measurement_unit.to_i).to eq 3
  end

  it 'should container the price ' do
    expect(@food.price).to eq 1
  end
end
