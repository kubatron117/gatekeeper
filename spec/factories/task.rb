FactoryBot.define do
  factory :task do
    subject     { Faker::Lorem.sentence(word_count: 3)[0..254] }
    description { Faker::Lorem.paragraph(sentence_count: 2)[0..1999] }
    status      { :created }
    association :user
    association :project

    trait :in_progress do
      status { :in_progress }
    end
  end
end