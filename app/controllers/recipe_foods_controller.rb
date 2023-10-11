class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!, only: %i[destroy]

  def index
    @recipes = Recipe.includes(:recipe_foods, :user).where(public: true).order(created_at: :desc)
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
end
