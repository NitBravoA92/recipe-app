require 'rails_helper'

describe "Visit the index page of 'foods'", type: :feature do
  # logged in before run the tests
  before do
    id = rand(20_000..30_000)
    email = "user_foods_index#{id}@mailfoods.com"
    user = FactoryBot.create(:user, id:, email:)
    FactoryBot.create(:food, user:)
    login_as(user)
  end

  it 'should display the title of the page' do
    visit foods_path
    expect(page).to have_content 'Foods List'
  end

  it 'should display the Add Food button' do
    visit foods_path
    expect(page).to have_selector('button')
    expect(page).to have_content 'Add Food'
  end

  it "should display the foods's table where all foods are listed" do
    visit foods_path
    expect(page).to have_selector('table')

    expect(page).to have_content 'Food'
    expect(page).to have_content 'Measurement unit'
    expect(page).to have_content 'Unit price'
    expect(page).to have_content 'Quantity'
    expect(page).to have_content 'Actions'
  end

  it "should display a food's name" do
    visit foods_path
    expect(page).to have_content 'Apple'
  end

  it "should display a food's Measurement unit" do
    visit foods_path
    expect(page).to have_content 'grams'
  end

  it "should display a food's Unit price" do
    visit foods_path
    expect(page).to have_content '$2.15'
  end

  it "should display a food's Quantity" do
    visit foods_path
    expect(page).to have_content '1'
  end

  it 'should display the Delete button' do
    visit foods_path
    expect(page).to have_selector('button')
    expect(page).to have_content 'Delete'
  end

  it "Clicking on the 'Add Food' button should redirect to foods's new page" do
    visit foods_path
    click_link 'Add Food'
    expect(page).to have_current_path(new_food_path)
  end

  it "Clicking on the 'Delete' button should remove a food from the table and redirect to foods's page" do
    visit foods_path
    click_button 'Delete'
    expect(page).to have_current_path(foods_path)
    expect(page).to have_content 'The Food was deleted successfully!'
  end
end
