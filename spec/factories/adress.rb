FactoryBot.define do
  factory :address do
    street_name   { Faker::Address.street_name[0..99] }
    street_number { Faker::Address.building_number[0..19] }
    city          { Faker::Address.city[0..99] }
    postal_code   { Faker::Address.postcode[0..19] }
    country_name  { Faker::Address.country[0..99] }
  end
end