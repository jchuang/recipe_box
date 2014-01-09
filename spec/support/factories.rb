# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :recipe do
    name 'tasty food'
    ingredients 'here are the ingredients'
    directions 'here are the directions'
    visibility 'Public'

    trait :fast do
      time_number '15'
      time_unit 'minutes'
      name 'fast recipe'
    end

    trait :medium do
      time_number '30'
      time_unit 'minutes'
      name 'medium recipe'
    end

    trait :slow do
      time_number '1.5'
      time_unit 'hours'
      name 'slow recipe'
    end
  end

end
