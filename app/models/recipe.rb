class Recipe < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :foods

  # Validations.
  validates :name, :description, presence: true
  validates :name, length: { maximum: 250 }
  validates :preparation_time, :cooking_time, presence: true, comparison: { greater_than_or_equal_to: 0 },
                                              numericality: { only_integer: true }
  validates :public, inclusion: { in: [true, false] }
end
