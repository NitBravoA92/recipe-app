require 'rails_helper'

describe "Visit the new page of 'foods'", type: :feature do
  # logged in before run the tests
  before do
    user = FactoryBot.create(:user)
    food = FactoryBot.create(:food, user: user)
    login_as(user)
  end

  it 'should display the title of the page' do
    visit new_food_path
    expect(page).to have_content 'Create a new food'
  end
end
