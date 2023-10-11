FactoryBot.define do
  factory :user do
    id { rand(1..5000) }
    name { 'Gerard' }
    email { "user_#{id}@mail.com" }
    password  { 'gerard12345' }
    confirmed_at { Time.now }
  end
end
