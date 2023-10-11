FactoryBot.define do
  factory :recipe do
    user
    name { 'Cookies' }
    preparation_time { 30 }
    cooking_time { 12 }
    description do
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    end
    public { true }
  end
end
