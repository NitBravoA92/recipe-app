class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!, only: %i[destroy]
  before_action :foods_by_recipe, except: [:index]

  def index
    @recipes = Recipe.includes(:recipe_foods, :user).where(public: true).order(created_at: :desc)
  end

  def new
    @recipe_food = @recipe_food.new
  end

  def create
    recipe_food = @recipe_food.new(recipe_food_params)
    if recipe_food.save
      flash[:notice] = 'The ingredient was added successfully!'
      redirect_to recipe_path(@recipe)
    else
      flash[:alert] = recipe_food.errors.full_messages.join(', ')
      redirect_to request.referrer
    end
  end

  def edit
    @recipe_food = @recipe_food.find_by(id: params[:id])
  end

  def update
    recipe_food = @recipe_food.find_by(id: params[:id])

    if recipe_food.update(recipe_food_params)
      flash[:notice] = 'The ingredient was modified successfully!'
      redirect_to recipe_path(@recipe)
    else
      flash[:alert] = recipe_food.errors.full_messages.join(', ')
      redirect_to request.referrer
    end
  end

  def destroy
    recipe_food = RecipeFood.find(params[:id])
    recipe = recipe_food.recipe
    if recipe_food.destroy
      flash[:notice] = 'The Food was remove successfully!'
    else
      flash[:alert] = 'The Food was not remove!'
    end
    redirect_to recipe_path(recipe)
  end

  def general_shopping_list
  	# Select all the recipe foods for all the recipes of the logged user.
		@general_recipe_foods = current_user.recipes.recipe_foods
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end

  def foods_by_recipe
    @foods = current_user.foods.all
    @recipe = Recipe.find_by(id: params[:recipe_id])
    @recipe_food = @recipe.recipe_foods
    # Select the foods that are not in the recipe.
    @foods_not_in_recipe = @foods.where.not(id: @recipe_food.pluck(:food_id))
  end
end
