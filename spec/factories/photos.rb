# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
    dive_id 1
    image Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/fish.jpg')))
  end
end
