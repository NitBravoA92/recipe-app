class RecipeFood < ApplicationRecord
  belongs_to :recipe, class_name: 'Recipe'
  belongs_to :food, class_name: 'Food'
  after_create :increment_quantity

  def increment_quantity
    recipe_foods = RecipeFood.where(recipe_id:)
    recipe_foods.each do |recipe_food|
      recipe_food.increment!(:quantity)
    end
  end
end
