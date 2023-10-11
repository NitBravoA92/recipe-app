require 'rails_helper'

RSpec.describe 'Recipe', type: :feature do
	describe 'Visit the new page of recipes' do
		# logged in before run the tests
    before do
      user = FactoryBot.create(:user)
      FactoryBot.create(:recipe, user:)
      login_as(user)
    end

    it 'Should display the title of the page' do
    	visit new_recipe_path
    	expect(page).to have_content 'Create a new Recipe'
    end

    it 'should display a form with the fields to create a recipe' do
    	visit new_recipe_path
    	expect(page).to have_selector('form')
    	expect(page).to have_css('input[type="text"]')
      expect(page).to have_css('input[type="number"]')
      expect(page).to have_css('input[type="radio"]')

      expect(page).to have_content 'Name'
      expect(page).to have_content 'Preparation time (hours):'
      expect(page).to have_content 'Cooking time (hours):'
      expect(page).to have_content 'Description'
      expect(page).to have_content 'Public'
      expect(page).to have_content 'Private'
    end

    it 'should have a submit input and cancel button' do
    	visit new_recipe_path
    	expect(page).to have_css('input[type="submit"]')
    	expect(page).to have_content 'Cancel'
    end

    it "Clicking on the 'Cancel' button should redirect to the recipe's index page" do
    	visit new_recipe_path
    	click_link 'Cancel'
    	expect(page).to have_current_path(recipes_path)
    end

    it "Clicking on the 'Save Recipe' button should send the form and create a new recipe" do
    	visit new_recipe_path

    	within('form') do
    		fill_in 'recipe[name]', with: 'Coffee'
    		fill_in 'recipe[preparation_time]', with: 1.5
    		fill_in 'recipe[cooking_time]', with: 0.5
    		fill_in 'recipe[description]', with: 'New description...'
    	end

    	click_button 'Save recipe'

    	expect(page).to have_current_path(recipes_path)
    	expect(page).to have_content 'The Recipe was created successfully!'
    end
	end
end