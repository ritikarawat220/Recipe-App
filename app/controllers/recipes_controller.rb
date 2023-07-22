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
    @inventory = Inventory.find(params[:inventory_id])
    @recipe = Recipe.find(params[:recipe_id])
    recipe_foods = @recipe.recipe_foods
    inventory_foods = @inventory.inventory_foods

    @missing_foods = find_missing_foods(recipe_foods, inventory_foods)
    @total_cost = calculate_total_cost(@missing_foods)

    render :shopping_list, locals: {
      missing_foods: @missing_foods,
      total_cost: @total_cost,
      recipe: @recipe,
      inventory: @inventory
    }
  end

  private

  def find_missing_foods(recipe_foods, inventory_foods)
    missing_foods = []
    recipe_foods.each do |recipe_food|
      food = recipe_food.food
      inventory_food = inventory_foods.find_by(food_id: food.id)
      next unless inventory_food.nil? || inventory_food.quantity < recipe_food.quantity

      missing_quantity = inventory_food.nil? ? recipe_food.quantity : recipe_food.quantity - inventory_food.quantity
      missing_foods << {
        name: food.name,
        missing_quantity:,
        cost: missing_quantity * food.price
      }
    end
    missing_foods
  end

  def calculate_total_cost(missing_foods)
    missing_foods.reduce(0) { |total, food| total + food[:cost] }
  end

  def recipe_params
    params.require(:recipe).permit(:name, :cooking_time, :preparation_time, :description, :public, :user_id)
  end
end
