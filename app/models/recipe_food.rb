class RecipeFood < ApplicationRecord
  belongs_to :recipe, class_name: 'Recipe'
  belongs_to :food, class_name: 'Food'

  # Avoids duplicated ingredients in the same recipe, but allows the use of the same ingredients in different recipes.
  validates :food_id, uniqueness: { scope: :recipe_id }

  # methods
  def total_price
    (quantity * food.price).round(2)
  end
end
