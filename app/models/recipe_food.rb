class RecipeFood < ApplicationRecord
  belongs_to :recipe, class_name: 'Recipe'
  belongs_to :food, class_name: 'Food'

  # Avoids duplicated ingredients.
	validates :food_id, uniqueness: true
end
