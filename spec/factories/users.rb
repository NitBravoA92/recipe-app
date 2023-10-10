FactoryBot.define do
  factory :user do
    id {1}
    name { 'Gerard' }
    email { 'gerard123@domain.com' }
    password  { 'gerard12345' }
    confirmed_at { Time.now }
  end
end
