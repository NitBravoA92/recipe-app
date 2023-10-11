require 'rails_helper'

RSpec.describe 'Recipe', type: :feature do
  describe 'Visit the index page of recipes' do
    # logged in before run the tests
    before do
      user = FactoryBot.create(:user)
      FactoryBot.create(:recipe, user:)
      login_as(user)
    end
    let(:recipe) { create(:recipe) }

    it 'should display the title of the page' do
      visit recipes_path
      expect(page).to have_content 'Recipes List'
    end

    it 'should display the add Recipe button' do
      visit recipes_path
      expect(page).to have_selector('.Add-recipe', text: 'Add Recipe')
    end

    it 'should display the recipe name' do
      visit recipes_path
      within('.recipes') do
        expect(page).to have_selector('.recipes-links', text: 'Cookies')
      end
    end

    it 'should display the recipe description' do
      visit recipes_path
      within('.recipes') do
        expect(page).to have_selector('p',
                                      text: 'Lorem Ipsum is simply dummy text of the printing and typesetting')
      end
    end

    it 'should display the remove button' do
      visit recipes_path
      within('.recipes') do
        expect(page).to have_selector('.Remove-recipe', text: 'Remove')
      end
    end

    it "clicking on the 'Add Recipe' button should redirect to the recipe's new page" do
      visit recipes_path
      click_link 'Add Recipe'
      expect(page).to have_current_path(new_recipe_path)
    end

    #     it "Clicking on the recipe's name should redirect to the recipe details page" do
    #     	visit recipes_path
    #     	click_link 'Cookies'
    #     	expect(page).to have_current_path(recipe_path(@recipe))
    #     end

    it "Clicking on the 'Remove' button should delete the recipe" do
      visit recipes_path
      click_link 'Remove'
      expect(page).to have_current_path(recipes_path)
      expect(page).to have_content 'The Recipe was deleted successfully!'
    end
  end
end
