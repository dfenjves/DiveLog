class Fish < ActiveRecord::Base
  has_many :dives, through: :divefish
  has_many :divefishes
end
