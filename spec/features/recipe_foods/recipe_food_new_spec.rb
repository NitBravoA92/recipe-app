require 'rails_helper'

describe "Visit the new page of 'recipe foods'", type: :feature do
  # logged in before run the tests
  before do
    id = rand(5000..10_000)
    mail = "frank_test_for_new#{id}@example.com"
    user = User.create(id:, name: 'Frank test', email: mail, password: '123456password', confirmed_at: Time.now)

    @recipe = Recipe.create(user:, name: 'Recipe for test', preparation_time: 120, cooking_time: 90,
                            description: 'Test 2', public: true)

    Food.create(user:, name: 'Chicken', measurement_unit: 'grams', price: 2.10, quantity: 2)

    login_as(user)
    visit new_recipe_recipe_food_path(@recipe)
  end

  it 'should display the title of the page' do
    expect(page).to have_content 'Add an ingredient'
  end

  it 'should display a form with the fields to add a new food to a recipe' do
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

  it "Clicking on the 'Save ingredient' button should send the form and add the food to a recipe" do
    within('form') do
      fill_in 'Quantity', with: 1
    end

    page.select 'Chicken', from: 'recipe_food[food_id]'

    click_button 'Save ingredient'

    expect(page).to have_current_path(recipe_path(@recipe))
  end
end
