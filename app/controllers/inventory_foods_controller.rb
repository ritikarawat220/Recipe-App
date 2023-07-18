class InventoryFoodsController < ApplicationController
  before_action :set_inventory

  def new
    @inventory_food = @inventory.inventory_foods.build
    @foods = Food.all
  end

  def create
    @inventory_food = @inventory.inventory_foods.build(inventory_food_params)

    if @inventory_food.save
      redirect_to inventory_path(@inventory), notice: 'Food linked to inventory successfully!'
    else
      @foods = Food.all
      render :new
    end
  end

  def destroy
    @inventory_food = @inventory.inventory_foods.find(params[:id])
    @inventory_food.destroy
    redirect_to inventory_path(@inventory), notice: 'Inventory food deleted successfully!'
  end

  private

  def set_inventory
    @inventory = Inventory.find(params[:inventory_id])
  end

  def inventory_food_params
    params.require(:inventory_food).permit(:food_id, :quantity, :quantity_unit)
  end
end
