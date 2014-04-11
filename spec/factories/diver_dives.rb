# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :diver_dive, :class => 'DiverDive' do
    diver_id 1
    dive_id 1
  end
end
