require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
	# Request to /recipes
	describe 'GET index' do
		# the user Gerard logged in before run the tests
    before do
      user = FactoryBot.create(:user)
      FactoryBot.create(:recipe, user:)
      sign_in user
      get recipes_path
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
      expected_result = 'Recipes List'
      expect(response.body).to include(expected_result)

      expected_result_recipe = 'Cookies'
      expect(response.body).to include(expected_result_recipe)
    end
	end

	# Request to /recipes/new
	describe 'GET /new' do
		before do
      user = FactoryBot.create(:user)
      sign_in user
     	get new_recipe_path
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
    it 'renders the index template with correct content' do
      expected_result = 'Create a new Recipe'
      expect(response.body).to include(expected_result)

      expected_result_button = 'Save recipe'
      expect(response.body).to include(expected_result_button)
    end
	end
end
