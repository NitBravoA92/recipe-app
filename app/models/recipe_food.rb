class RecipeFood < ApplicationRecord
  belongs_to :recipe, class_name: 'Recipe'
  belongs_to :food, class_name: 'Food'

  # Avoids duplicated ingredients.
  validates :food_id, uniqueness: true

  #methods
  def get_total_price
    (self.quantity * food.price).round(2)
  end
end
