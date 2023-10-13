class FoodsController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create destroy]
  before_action :food_by_user, only: %i[index new create destroy]

  def index
    @foods = current_user.foods.all
  end

  def new
    @food = @food.new
  end

  def create
    food = @food.new(food_params)
    render :new unless food.save
    flash[:notice] = 'The Food was created successfully!'
    redirect_to foods_path
  end

  def destroy
    food = @food.find(params[:id])
    if food.destroy
      flash[:notice] = 'The Food was deleted successfully!'
    else
      flash[:alert] = 'The Food was not deleted!'
    end
    redirect_to foods_path
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end

  def food_by_user
    @food = current_user.foods
  end
end
