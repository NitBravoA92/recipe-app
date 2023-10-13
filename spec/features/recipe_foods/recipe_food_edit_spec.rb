require 'rails_helper'

describe "Visit the edit page of 'recipe foods'", type: :feature do
  # logged in before run the tests
  before do
    id = rand(5000..10_000)
    mail = "frank_test#{id}@example.com"
    user = User.create(id: id, name: 'James test', email: mail, password: '123456password', confirmed_at: Time.now)

    @recipe = Recipe.create(user: user, name: 'Recipe for test', preparation_time: 120, cooking_time: 90, description: 'Test edit', public: true)

    food = Food.create(user: user, name: 'Lemon', measurement_unit: 'grams', price: 2.05, quantity: 4)

    recipe_food = RecipeFood.create(recipe: @recipe, food: food, quantity: 1)

    login_as(user)
    visit edit_recipe_recipe_food_path(@recipe, recipe_food)
  end

  it 'should display the title of the page' do
    expect(page).to have_content 'Edit an ingredient'
  end

  it 'should display a form with the fields to edit a food of a recipe' do
    expect(page).to have_selector('form')
    expect(page).to have_css('input[type="number"]')
    expect(page).to have_selector('select')

    expect(page).to have_content 'Select your ingredient'
    expect(page).to have_content 'Quantity'
  end

  it 'should have a form with a submit input and a Cancel button' do
    expect(page).to have_css('input[type="submit"]')
    expect(page).to have_content 'Cancel'
  end

  it "Clicking on the Cancel button should redirect to recipe's show page" do
    click_link 'Cancel'
    expect(page).to have_current_path(recipe_path(@recipe))
  end

  it "Clicking on the 'Save ingredient' button should send the form and edit the food" do
    within('form') do
      fill_in 'Quantity', with: 2
    end

    page.select 'Lemon', from: 'recipe_food[food_id]'

    click_button 'Save ingredient'

    expect(page).to have_current_path(recipe_path(@recipe))
  end
end
