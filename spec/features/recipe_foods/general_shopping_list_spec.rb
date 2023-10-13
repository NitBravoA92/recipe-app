require 'rails_helper'

describe "Visit the general_shopping_list page of 'recipe foods'", type: :feature do
  # logged in before run the tests
  before do
    id = rand(10_000..15_000)
    mail = "james_test_shopping_list#{id}@example.com"
    user = User.create(id:, name: 'James test', email: mail, password: '123456password', confirmed_at: Time.now)

    login_as(user)
    visit general_shopping_list_path
  end

  it 'should display the title of the page' do
    expect(page).to have_content 'Shopping List'
  end

  it 'should display the Amount of food items to buy' do
    expect(page).to have_content 'Amount of food items to buy: 0'
  end

  it 'should display the Total value of food needed' do
    expect(page).to have_content 'Total value of food needed: $0'
  end

  it 'should display the foods table where all missing foods are listed' do
    expect(page).to have_selector('table')

    expect(page).to have_content 'Food'
    expect(page).to have_content 'Price'
    expect(page).to have_content 'Quantity'
  end
end
