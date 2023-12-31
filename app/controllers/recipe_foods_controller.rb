class RecipeFoodsController < ApplicationController
  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new(recipe_id: params[:recipe_id])
    @foods = Food.all
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @add_recipe_food = @recipe.recipe_foods.build(recipe_food_params)

    if @add_recipe_food.save
      flash[:notice] = 'Food linked to recipe successfully!'
      redirect_to recipe_path(@recipe)
    else
      @foods = Food.all
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.find(params[:id])
    @foods = Food.all
  end

  def update
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.find(params[:id])

    if @recipe_food.update(recipe_food_params)
      flash[:notice] = 'Recipe food updated successfully!'
      redirect_to recipe_path(@recipe)
    else
      @foods = Food.all
      render :show
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.find(params[:id])

    if @recipe_food.destroy
      flash[:notice] = 'Recipe food deleted successfully!'
    else
      flash[:alert] = 'Recipe food could not be deleted!'
    end
    redirect_to recipe_path(@recipe)
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
