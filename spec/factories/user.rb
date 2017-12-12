FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password "whatapassword"
    password_confirmation "whatapassword"
  end
  
  factory :invalid_user, parent: :user do
    name nil
    email nil
    password "short"
    password_confirmation "short"
  end
end
