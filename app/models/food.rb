class Food < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :recipes, join_table: 'recipe_foods'
  has_many :recipe_foods

  # validations
  validates :name, :measurement_unit, :price, :quantity, presence: true
  validates :name, length: { maximum: 150 }
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  def name_with_measurement_unit
    "#{name} (#{measurement_unit})"
  end

	# Method to calculate the total food in all the recipes without the existing food of the user.
  def general_food_quantity
     self.recipe_foods.joins(:food).sum('recipe_foods.quantity')
  end

  def total_food
  	(general_food_quantity - quantity).abs
  end

	# Method to calculate the total price of an ingredient.
  def general_price
  	total_food * price
  end

  # Method to calculate the total amount of price of the ingredients.

end
