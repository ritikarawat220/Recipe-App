class PublicRecipesController < ApplicationController
  def index
    @recipes = Recipe.find_by status: 'public'
  end

  def show
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])
    @recipe_id = @recipe.id
    @inventories = Inventory.all

    render :show
  end
end