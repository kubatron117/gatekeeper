FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name[0..99] }
    last_name  { Faker::Name.last_name[0..99] }
    email      { Faker::Internet.unique.email }
    password   { 'Password123' }
    password_confirmation { 'Password123' }

    trait :admin do
      role { :admin }
    end
  end
end
