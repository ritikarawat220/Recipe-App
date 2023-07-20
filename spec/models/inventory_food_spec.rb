require 'rails_helper'

RSpec.describe InventoryFood, type: :model do
  let(:food) { Food.create(name: 'Kheer', measurement_unit: 3, price: 1) }
  let(:inventory) { Inventory.create(name: 'My Inventory') }

  before :each do
    @inventory_food = InventoryFood.create(
      quantity: 10,
      food:
    )
  end

  it 'should have a quantity' do
    expect(@inventory_food.quantity).to eq(10)
  end

  it 'should have an index on food_id' do
    expect(InventoryFood.connection.index_exists?(:inventory_foods, :food_id)).to be_truthy
  end
end
