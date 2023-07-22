require 'rails_helper'

RSpec.describe Inventory, type: :model do
  let(:user) { User.create(name: 'John Doe') }

  before :each do
    @inventory = Inventory.new(
      name: 'My Inventory',
      user:,
      description: 'This is a test inventory'
    )
    @inventory.save
  end

  it 'should have a name' do
    expect(@inventory.name).to eq('My Inventory')
  end

  it 'should have a description' do
    expect(@inventory.description).to eq('This is a test inventory')
  end

  it 'should belong to a user' do
    expect(@inventory.user).to eq(user)
  end

  it 'should have many inventory foods' do
    expect(@inventory.inventory_foods).to be_empty
    food = Food.create(name: 'Food 1')
    inventory_food = @inventory.inventory_foods.build(food:)
    @inventory.save
    expect(@inventory.inventory_foods).to include(inventory_food)
  end

  it 'should have many foods through inventory foods' do
    expect(@inventory.foods).to be_empty
    food = Food.create(name: 'Food 1')
    @inventory.inventory_foods.build(food:)
    @inventory.save
    expect(@inventory.foods).to include(food)
  end

  it 'should validate presence of name' do
    inventory = Inventory.new(description: 'This is a test inventory')
    expect(inventory.valid?).to be_falsey
    expect(inventory.errors[:name]).to include("can't be blank")
  end

  it 'should validate presence of user' do
    inventory = Inventory.new(name: 'My Inventory', description: 'This is a test inventory')
    expect(inventory.valid?).to be_falsey
    expect(inventory.errors[:user]).to include('must exist')
  end

  it 'should validate presence of description' do
    inventory = Inventory.new(name: 'My Inventory')
    expect(inventory.valid?).to be_falsey
    expect(inventory.errors[:description]).to include("can't be blank")
  end
end
