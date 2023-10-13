require 'rails_helper'

RSpec.describe 'Recipe', type: :feature do
  describe 'Visit the show page of recipes' do
    # logged in before run the tests
    before do
      user = FactoryBot.create(:user)
      @recipe = FactoryBot.create(:recipe, user:)

      food = Food.create(id: 704_767, user:, name: 'Orange', measurement_unit: 'grams', price: 1.50, quantity: 5)
      RecipeFood.create(id: 9_843_830, recipe: @recipe, food:, quantity: 1)

      @recipe_modify = Recipe.create(id: 40_596_739, user:, name: 'Recipe for test modify', preparation_time: 180,
                                     cooking_time: 120, description: 'Test recipe details', public: true)
      @recipe_food_modify = RecipeFood.create(id: 6_843_830, recipe: @recipe_modify, food:, quantity: 2)

      login_as(user)
    end

    it 'should display the title of the page' do
      visit recipe_path(@recipe)
      expected_result = @recipe.name
      expect(page).to have_content expected_result.to_s
    end

    it 'should display the Preparation Time of the recipe' do
      visit recipe_path(@recipe)
      expected_result = @recipe.preparation_time.to_i.to_f / 60
      expect(page).to have_content "Preparation Time: #{expected_result} hours"
    end

    it 'should display the Cooking Time of the recipe' do
      visit recipe_path(@recipe)
      expected_result = @recipe.cooking_time.to_i.to_f / 60
      expect(page).to have_content "Cooking Time: #{expected_result} hours"
    end

    it 'should display the description of the recipe' do
      visit recipe_path(@recipe)
      expected_result = @recipe.description
      expect(page).to have_content expected_result.to_s
    end

    it 'should display the Add Ingredient button' do
      visit recipe_path(@recipe)
      expect(page).to have_selector('.btn', text: 'Add Ingredient')
    end

    it "clicking on the 'Add Ingredient' button should redirect to the 'Add Ingredient' page" do
      visit recipe_path(@recipe)
      click_link 'Add Ingredient'
      expect(page).to have_current_path(new_recipe_recipe_food_path(@recipe))
    end

    it 'should display the Generate shopping list button' do
      visit recipe_path(@recipe)
      expect(page).to have_selector('.btn', text: 'Generate shopping list')
    end

    it "clicking on the 'Generate shopping list' button should redirect to the 'Generate shopping list' page" do
      visit recipe_path(@recipe)
      click_link 'Generate shopping list'
      expect(page).to have_current_path(general_shopping_list_path)
    end

    it 'should display the table where all recipe foods are listed' do
      visit recipe_path(@recipe)
      expect(page).to have_selector('table')

      expect(page).to have_content 'Food'
      expect(page).to have_content 'Quantity'
      expect(page).to have_content 'Value'
      expect(page).to have_content 'Actions'
    end

    it 'Clicking on the Modify button of a food should redirect to the Edit Ingredient page' do
      visit recipe_path(@recipe_modify)
      click_link 'Modify'
      expect(page).to have_current_path(edit_recipe_recipe_food_path(@recipe_modify, @recipe_food_modify))
    end

    it 'Clicking on the Remove button of a food should remove it and redirect to the recipe details page' do
      visit recipe_path(@recipe)
      click_button 'Remove'
      expect(page).to have_current_path(recipe_path(@recipe))
    end
  end
end
