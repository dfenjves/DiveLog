class Fish < ActiveRecord::Base
  has_many :dives, through: :dive_fishes
  has_many :dive_fishes
end
