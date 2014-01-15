# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :recipe do
    sequence(:name) { |n| "tasty food #{n}" }
    ingredients 'here are the ingredients'
    directions 'here are the directions'
    visibility 'Public'

    trait :fast do
      sequence(:name) { |n| "fast recipe #{n}"}
      time_number '15'
      time_unit 'minutes'
    end

    trait :medium do
      sequence(:name) { |n| "medium recipe #{n}"}
      time_number '30'
      time_unit 'minutes'
    end

    trait :slow do
      sequence(:name) { |n| "slow recipe #{n}"}
      time_number '1.5'
      time_unit 'hours'
    end
  end

  factory :comment do
    sequence(:body) { |n| "comment text #{n}" }
    recipe
  end

  factory :tag do
    sequence(:name) { |n| "tag #{n}" }
  end

  factory :recipe_tag do
    recipe
    tag
  end

end
