class Recipe < ApplicationRecord
  # before_validation :convert_hours_to_minutes
  belongs_to :user
  has_and_belongs_to_many :foods, join_table: 'recipe_foods'
  has_many :recipe_foods

  # Validations.
  validates :name, :description, presence: true
  validates :name, length: { maximum: 250 }
  validates :preparation_time, :cooking_time, presence: true, comparison: { greater_than_or_equal_to: 0 },
                                              numericality: { only_integer: true }
  validates :public, inclusion: { in: [true, false] }

  def total_price
    recipe_foods.includes(:food).sum { |recipe_food| recipe_food.food.price * recipe_food.quantity }
  end

  def count_ingredients
    foods.count
  end

  def convert_hours_to_minutes
    self.preparation_time = (preparation_time.to_f * 60).to_i
    self.cooking_time = (cooking_time.to_f * 60).to_i
  end
end
