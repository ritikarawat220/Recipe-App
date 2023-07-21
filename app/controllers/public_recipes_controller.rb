class PublicRecipesController < ApplicationController
  def index
    @public_recipes = Recipe.all.where(status: 'public') && Recipe.all.where.not(user_id: current_user.id)
  end

  def show
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])
    @recipe_id = @recipe.id
    @inventories = Inventory.all

    render :show
  end
end
