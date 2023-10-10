require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { create(:user) }

  describe "user" do
    it "should be valid" do
      expect(user).to be_valid
    end
  end
end
