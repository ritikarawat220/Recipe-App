class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes.includes(:recipe_foods)
  end

  def show
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])
    @recipe_id = @recipe.id
    @inventories = Inventory.all

    render :show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipes_path, notice: 'Recipe created successfully!' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { redirect_to new_recipe_path, alert: 'Recipe not created!' }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      flash[:notice] = 'Recipe deleted successfully!'
    else
      flash[:alert] = 'Recipe not deleted!'
    end
    redirect_to recipes_path
  end

  def shopping_list
    recipe_id = params[:recipe_id]
    params[:inventory_id]

    @recipe = recipe_id
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :cooking_time, :preparation_time, :description, :status, :user_id)
  end
end
