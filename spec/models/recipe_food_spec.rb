require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:recipe_food) { create(:recipe_food) }

  describe 'recipe food' do
    it 'should be valid' do
      expect(recipe_food).to be_valid
    end
  end

  describe 'recipe food validations' do
    let(:recipe) { create(:recipe) }
    let(:food) { create(:food) }

    it 'the food same food should be not be present twice in the same recipe' do
      first_recipe_food = RecipeFood.create(food: food, recipe: recipe, quantity: 5)
      second_recipe_food = RecipeFood.create(food: food, recipe: recipe, quantity: 8) 

      expect(second_recipe_food).to_not be_valid
    end
  end

  describe 'recipe food attributes' do
    it 'a food with the value = nil should not be valid' do
      recipe_food.food = nil
      expect(recipe_food).to_not be_valid
    end

    it 'a food with the name = Apple should be a valid record' do
      expect(recipe_food.food).to be_valid
    end

    it 'a recipe with the value = nil should not be valid' do
      recipe_food.recipe = nil
      expect(recipe_food).to_not be_valid
    end

    it 'a recipe with the name = Cookie should be a valid record' do
      expect(recipe_food.recipe).to be_valid
    end

    it 'the quantity value = 20 should be valid' do
      recipe_food.quantity = 20
      expect(recipe_food).to be_valid
    end
  end
end
