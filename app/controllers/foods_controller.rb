class FoodsController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create destroy]
  def index
    @foods = current_user.foods.all
  end
end
