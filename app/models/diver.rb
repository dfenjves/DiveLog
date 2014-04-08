class Diver < ActiveRecord::Base
  has_many :dives, through: :diverdive
  has_many :diverdives
end
