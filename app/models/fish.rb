class Fish < ActiveRecord::Base
  has_many :dives, through: :divefishes
  has_many :divefishes
end
