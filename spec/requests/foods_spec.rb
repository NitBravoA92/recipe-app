require 'rails_helper'

RSpec.describe 'Foods', type: :request do

  # request to: /foods
  describe 'GET /index' do
    # the user Gerard logged in before run the tests
    before do
      user = FactoryBot.create(:user)
      food = FactoryBot.create(:food, user: user)
      sign_in user
      get foods_path
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
      expected_result = 'Foods List'
      expect(response.body).to include(expected_result)

      expected_result_food = 'Apple'
      expect(response.body).to include(expected_result_food)
    end
  end
end
