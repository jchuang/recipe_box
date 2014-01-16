# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name "MyString"
    last_name "MyString"
    username "MyString"
    photo "MyString"
    profile_notes "MyText"
    last_signed_in "2014-01-16 14:55:49"
  end
end
