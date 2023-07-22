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

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe updated successfully!' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, alert: 'Recipe not updated!' }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.public = params[:recipe][:status] == 'Public'

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
    params.require(:recipe).permit(:name, :cooking_time, :preparation_time, :description, :public, :user_id)
  end
end
