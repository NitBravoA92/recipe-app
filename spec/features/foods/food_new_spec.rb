require 'rails_helper'

describe "Visit the new page of 'foods'", type: :feature do
  # logged in before run the tests
  before do
    user = FactoryBot.create(:user)
    FactoryBot.create(:food, user:)
    login_as(user)
  end

  it 'should display the title of the page' do
    visit new_food_path
    expect(page).to have_content 'Create a new food'
  end

  it 'should display a form with the fields to create a food' do
    visit new_food_path
    expect(page).to have_selector('form')
    expect(page).to have_css('input[type="text"]')
    expect(page).to have_css('input[type="number"]')
    expect(page).to have_selector('select')

    expect(page).to have_content 'Name'
    expect(page).to have_content 'Measurement unit'
    expect(page).to have_content 'Unit price'
    expect(page).to have_content 'Quantity'
  end

  it 'should have a form with a submit input and a Cancel button' do
    visit new_food_path
    expect(page).to have_css('input[type="submit"]')
    expect(page).to have_content 'Cancel'
  end

  it "Clicking on the Cancel button should redirect to foods's index page" do
    visit new_food_path
    click_link 'Cancel'
    expect(page).to have_current_path(foods_path)
  end

  it "Clicking on the 'Save food' button should send the form and create a new food" do
    visit new_food_path

    within('form') do
      fill_in 'Name', with: 'Pineapple'
      fill_in 'food[price]', with: 1.97
      fill_in 'Quantity', with: 1
    end

    page.select 'units', from: 'food[measurement_unit]'

    click_button 'Save food'

    expect(page).to have_current_path(foods_path)
    expect(page).to have_content 'The Food was created successfully!'
  end
end
