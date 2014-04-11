# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :diver do
    name "Bob"
    email "bob@bob.com"
    birthday "2014-04-08"
    certification_level "Expert"
    nationality "Sealandian"
  end
end
