require 'rails_helper'

RSpec.describe Food, type: :model do

  let(:food) { create(:food) }

  describe "food" do
    it "should be valid" do
      expect(food).to be_valid
    end

    it "should be owned by Gerard" do
      expect(food.user.name).to eq("Gerard")
    end
  end
end
