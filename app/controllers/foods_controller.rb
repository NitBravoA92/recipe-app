class FoodsController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create destroy]
  def index
    @foods = current_user.foods.all
  end

  def new
    @food = @food.new
  end

  private

  def food_by_user
    @food = current_user.foods
  end
end
