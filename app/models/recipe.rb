class Recipe < ApplicationRecord
  belongs_to :user

  # Validations.
  validates :name, presence: true, length: { maximum: 250 }
  validates :preparation_time, presence: true, comparison: { greater_than_or_equal_to: 0 }, numericality: { only_integer: true }
  validates :cooking_time, presence: true, comparison: { greater_than_or_equal_to: 0 }, numericality: { only_integer: true }
  validates :description, presence: true
  validates :public, inclusion: { in: [true, false] }
end
