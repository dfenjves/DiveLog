# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dive, :class => 'Dive' do
    date "2014-04-08"
    depth 1
    temperature 1
    time_in "2014-04-08 10:10:29"
    time_out "2014-04-08 10:12:29"
    dive_site "Wisconsin"
    visibility "clear"
    start_air 2
    end_air 1
    dive_type "boat"
    dive_activity "wreck"
    wetsuit false
    conditions "SomeConditions"
    notes "MyText"
  end
end
