FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password "whatapassword"
    password_confirmation "whatapassword"
    sequence(:phone) { |n| "0812225556#{n}" }
  end

  factory :invalid_user, parent: :user do
    name nil
    email nil
    password "short"
    password_confirmation "short"
    phone nil
  end
end
