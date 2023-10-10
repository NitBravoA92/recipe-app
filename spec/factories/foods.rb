FactoryBot.define do
  factory :food do
    user
    name { 'Apple' }
    measurement_unit { 'grams' }
    price  { 2.15 }
    quantity { 1 }
  end
end
