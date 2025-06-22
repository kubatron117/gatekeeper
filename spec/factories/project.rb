FactoryBot.define do
  factory :project do
    name        { Faker::Lorem.words(number: 3).join(' ')[0..254] }
    description { Faker::Lorem.sentence(word_count: 10)[0..1999] }
  end
end
