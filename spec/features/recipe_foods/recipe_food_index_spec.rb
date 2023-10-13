require 'rails_helper'

describe 'Visit the public_recipes page', type: :feature do
  let(:recipe) { create(:recipe) }

  before do
    user = User.create(id: 767_765, name: 'Frank', email: 'frank_1@example.com', password: '123456password',
                       confirmed_at: Time.now)
    @recipe = Recipe.create(user:, name: 'Recipe test', preparation_time: 50, cooking_time: 40,
                            description: 'Test', public: true)
    visit public_recipes_path
  end

  it 'should display the title of the page' do
    expect(page).to have_content 'Public Recipes'
  end

  it 'should display the public recipes' do
    expect(page).to have_selector('.recipes')

    expect(page).to have_content 'Recipe test'
    expect(page).to have_content 'By: Frank'
    expect(page).to have_content 'Total food items: 0'
    expect(page).to have_content 'Total price: $0'
  end

  it 'should not display a Delete button' do
    expect(page).to_not have_content 'Delete'
  end

  it "Clicking on a recipe's title should redirect to the recipe's details page" do
    click_link 'Recipe test'
    expect(page).to have_current_path(recipe_path(@recipe))
  end
end
