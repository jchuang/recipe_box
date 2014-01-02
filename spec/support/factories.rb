# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recipe do
    name 'green eggs and ham'
    ingredients 'here are the ingredients'
    directions 'here are the directions'
    visibility 'Public'
  end
end
