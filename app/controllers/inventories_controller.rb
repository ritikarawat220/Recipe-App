class InventoriesController < ApplicationController
  def index
    @inventories = current_user.inventories.includes(:user)
  end

  def show
    @inventory = Inventory.find(params[:id])
    @food = Food.new
  end

  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = current_user.inventories.new(inventory_params)
    if @inventory.save
      redirect_to inventory_path(@inventory), notice: 'Inventory was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @inventory = Inventory.find(params[:id])
    if @inventory.user == current_user
      @inventory.destroy
      redirect_to inventories_path, notice: 'Inventory was successfully deleted.'
    else
      redirect_to inventories_path, alert: 'You do not have permission to delete this inventory.'
    end
  end

  private

  def inventory_params
    params.require(:inventory).permit(:name, :description)
  end
end
