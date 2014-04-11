# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fish do
    name "Nemo"
    color "blue"
    length 10
    wiki_link "en.wikipedia.com/nemo"
    picture_link "http://someimage.jpg"
  end
end
