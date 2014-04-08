class Dive < ActiveRecord::Base
  has_many :fish, through: :divefish
  has_many :divefishes
  belongs_to :operator
  has_many :divers, through: :diverdive
  has_many :diverdives
end
