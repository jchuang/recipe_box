# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :identity do
    uid "MyString"
    provider "MyString"
    user_id 1
  end
end
