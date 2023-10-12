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
		render :new unless recipe_food.save
		flash[:notice] = 'The ingredient was added successfully!'
    redirect_to recipe_path(@recipe)
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

  private

  def recipe_food_params
  	params.require(:recipe_food).permit(:food_id, :quantity)
  end

  def foods_by_recipe
  	@foods = current_user.foods.all
  	@recipe = Recipe.find_by(id: params[:recipe_id])
		@recipe_food = @recipe.recipe_foods
	end
end
