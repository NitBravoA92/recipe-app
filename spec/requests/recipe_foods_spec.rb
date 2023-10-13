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
end
