require 'rails_helper'

RSpec.describe 'RecipeFoods', type: :request do
  describe 'GET /public_recipes' do
    # the user should not be logged in
    before do
      user = FactoryBot.create(:user)
      @recipe = FactoryBot.create(:recipe, user:)
      get public_recipes_path
    end

    # test if the response status was correct (status 200)
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    # test if a correct template was rendered.
    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    # test If the response body includes correct content.
    it 'renders the index template with correct content' do
      expected_result = 'Public Recipes'
      expect(response.body).to include(expected_result)

      expected_result_recipe = 'Cookies'
      expect(response.body).to include(expected_result_recipe)
    end
  end

  # Request to recipe/:recipe_id/recipe_foods/new
  describe 'GET /new' do
    before do
      user = FactoryBot.create(:user)
      recipe = FactoryBot.create(:recipe, user:)
      sign_in user
      get new_recipe_recipe_food_path(recipe)
    end

    # test if the response status was correct (status 200)
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    # test if a correct template was rendered.
    it 'renders the new template' do
      expect(response).to render_template(:new)
    end

    # test If the response body includes correct content.
    it 'renders the new template with correct content' do
      expected_result = 'Add an ingredient'
      expect(response.body).to include(expected_result)

      expected_result_field = 'Select your ingredient'
      expect(response.body).to include(expected_result_field)
    end
  end

  # Request to recipe/:recipe_id/recipe_foods/:recipe_food_id/edit
  describe 'GET /edit' do
    before do
      user = FactoryBot.create(:user)
      recipe = FactoryBot.create(:recipe, user:)
      @recipe_food = FactoryBot.create(:recipe_food, recipe:)
      sign_in user
      get edit_recipe_recipe_food_path(recipe, @recipe_food)
    end

    # test if the response status was correct (status 200)
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    # test if a correct template was rendered.
    it 'renders the new template' do
      expect(response).to render_template(:edit)
    end

    # test If the response body includes correct content.
    it 'renders the edit template with correct content' do
      expected_result = 'Edit an ingredient'
      expect(response.body).to include(expected_result)

      expected_result_field = 'quantity'
      expect(response.body).to include(expected_result_field)
    end
  end

  # Request to /general_shopping_list
  describe 'GET /general_shopping_list' do
    before do
      user = FactoryBot.create(:user)
      sign_in user
      get general_shopping_list_path
    end

    # test if the response status was correct (status 200)
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    # test if a correct template was rendered.
    it 'renders the new template' do
      expect(response).to render_template(:general_shopping_list)
    end

    # test If the response body includes correct content.
    it 'renders the general_shopping_list template with correct content' do
      expected_result = 'Shopping List'
      expect(response.body).to include(expected_result)
    end
  end
end
