class PublicRecipesController < ApplicationController
  def index
    @public_recipes = Recipe.select('recipes.*')
      .joins(:recipe_foods).joins(:foods)
      .select('SUM(foods.price) AS price, COUNT(foods.id) AS quantity')
      .group('recipes.id')
      .where(public: true).order(created_at: :desc)
  end

  def show
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])
    @recipe_id = @recipe.id
    @inventories = Inventory.all

    render :show
  end
end
