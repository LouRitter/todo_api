FactoryBot.define do
  factory :task do
    title { Faker::Company.unique.bs }
    user { User.first }
    trait :completed do
      completed { true }
    end
    trait :uncompleted do
      completed { false }
    end
    factory :completed_task, traits: [:completed]
    factory :uncompleted_task, traits: [:uncompleted]

  end
 end