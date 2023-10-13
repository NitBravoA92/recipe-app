require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:recipe_food) { create(:recipe_food) }

  describe 'recipe food' do
    it 'should be valid' do
      expect(recipe_food).to be_valid
    end
  end
end
