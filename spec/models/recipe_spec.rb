require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:recipe) { create(:recipe) }

  describe 'recipe' do
    it 'should be valid' do
      expect(recipe).to be_valid
    end

    it 'should be owned by Gerard' do
      expect(recipe.user.name).to eq('Gerard')
    end
  end

  describe 'recipe validations' do
    it 'the name should be present' do
      recipe.name = nil

      expect(recipe).to_not be_valid
    end

    it 'the name should not have more than 250 characters' do
      recipe.name = 'Chocolate' * 30

      expect(recipe).to_not be_valid
    end

    it 'preparation_time and cooking_time should be present' do
      recipe.preparation_time = nil
      recipe.cooking_time = nil

      expect(recipe).to_not be_valid
    end

    it 'preparation_time and cooking_time should be integers' do
      recipe.preparation_time = 5.2
      recipe.cooking_time = 5

      expect(recipe).to_not be_valid
    end

    it 'preparation_time and cooking_time should be greater than or equal to zero' do
      recipe.preparation_time = -3
      recipe.cooking_time = 1

      expect(recipe).to_not be_valid
    end

    it 'public attribute should only accept booleans' do
      recipe.public = 'not a boolean' # Will change it for the default value true.

      expect(recipe).to be_valid
    end
  end
end
