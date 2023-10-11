class RecipesController < ApplicationController
	before_action :recipe_by_user
  def index
    @recipes = current_user.recipes.all
  end

  def new
  	@recipe = @recipe.new
  end

  def create
  	recipe = @recipe.new(recipe_params)
    render :new unless recipe.save
    flash[:notice] = 'The Recipe was created successfully!'
    redirect_to recipes_path
  end

  private

  def recipe_params
  	# Convert the hours into minutes.
    params[:recipe][:preparation_time] = (params[:recipe][:preparation_time].to_f * 60).to_i
    params[:recipe][:cooking_time] = (params[:recipe][:cooking_time].to_f * 60).to_i

    #Require parameters
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end

  def recipe_by_user
    @recipe = current_user.recipes
  end
end
