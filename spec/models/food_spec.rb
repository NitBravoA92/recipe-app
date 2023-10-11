require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:food) { create(:food) }

  describe 'food' do
    it 'should be valid' do
      expect(food).to be_valid
    end

    it 'should be owned by Gerard' do
      expect(food.user.name).to eq('Gerard')
    end
  end

  describe 'attributes validation' do
    it 'The Food should not be valid without a name' do
      food.name = nil

      expect(food).to_not be_valid
    end

    it 'The Food should not be valid if the name has more than 150 characters' do
      food.name = 'Banana ' * 30

      expect(food).to_not be_valid
    end

    it 'The Food should be valid if the name is less than or equal to 150' do
      food.name = 'Apple' * 25

      expect(food).to be_valid
    end

    it 'The Food should not be valid without a measurement unit' do
      food.name = 'Pineapple'
      food.measurement_unit = nil

      expect(food).to_not be_valid
    end

    it 'The Food should not be valid without a price' do
      food.name = 'Banana'
      food.measurement_unit = 'units'
      food.price = nil

      expect(food).to_not be_valid
    end

    it 'The Food should not be valid without a quantity' do
      food.name = 'Banana'
      food.measurement_unit = 'units'
      food.price = 2.50
      food.quantity = nil

      expect(food).to_not be_valid
    end

    it 'The Food should not be valid if the quantity is not integer' do
      food.name = 'Olive Oil'
      food.measurement_unit = 'liters'
      food.quantity = true

      expect(food).to_not be_valid
    end

    it 'The Food should be valid if the quantity is greater than or equal to 0' do
      food.quantity = 20

      expect(food).to be_valid
    end
  end
end
