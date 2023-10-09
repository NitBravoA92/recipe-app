class RecipeFood < ApplicationRecord
  belongs_to :recipe, class_name: 'Recipe'
  belongs_to :food, class_name: 'Food'
end
