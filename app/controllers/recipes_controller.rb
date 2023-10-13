class RecipesController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create update_status destroy]
  before_action :recipe_by_user, only: %i[index new create destroy]

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

  def show
    @recipe = Recipe.find(params[:id])
    if can? :read, @recipe
      render :show
    else
      flash[:alert] = 'This recipe does not exist!'
      redirect_to public_recipes_path unless user_signed_in?
      redirect_to recipes_path if user_signed_in?
    end
  end

  def update_status
    recipe = Recipe.find(params[:id])
    status = recipe.public ? false : true
    result = recipe.update(public: status)
    flash[:notice] = 'The Recipe status was updated!' if result
    redirect_to recipe_path(recipe)
  end

  def destroy
    recipe = @recipe.find(params[:id])
    if recipe.destroy
      flash[:notice] = 'The Recipe was deleted successfully!'
    else
      flash[:alert] = 'The Recipe was not deleted!'
    end
    redirect_to recipes_path
  end

  private

  def recipe_params
    # Convert the hours into minutes.
    params[:recipe][:preparation_time] = (params[:recipe][:preparation_time].to_f * 60).to_i
    params[:recipe][:cooking_time] = (params[:recipe][:cooking_time].to_f * 60).to_i

    # Require parameters
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end

  def recipe_by_user
    @recipe = current_user.recipes
  end
end
