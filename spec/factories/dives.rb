# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dife, :class => 'Dive' do
    date "2014-04-08"
    depth 1
    temperature 1
    time_in "2014-04-08 10:12:29"
    time_out "2014-04-08 10:12:29"
    dive_site "MyString"
    visibility "MyString"
    start_air 1
    end_air 1
    dive_type "MyString"
    dive_activity "MyString"
    wetsuit "MyString"
    conditions "MyString"
    notes "MyText"
  end
end
