class ShoppingListController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])
    @recipe_id = @recipe.id
    @inventories = Inventory.all

    render :show
  end
end
