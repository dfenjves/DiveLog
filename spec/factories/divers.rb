# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :diver do
    name "MyString"
    email "MyString"
    birthday "2014-04-08"
    certification_level "MyString"
    nationality "MyString"
  end
end
