FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password "whatapassword"
    password_confirmation "whatapassword"
  end
end
