class Dive < ActiveRecord::Base
  has_many :fish, through: :divefish
  has_many :divefishes
  belongs_to :operator
  has_many :divers, through: :diverdive
  has_many :diverdives

  before_save :set_defaults

  def set_defaults
    self.depth = "Not Recorded" unless self.depth != ""
    self.temperature = "Not Recorded" unless self.temperature != ""
    self.visibility = "Not Recorded" unless self.visibility != ""
    self.start_air = "Not Recorded" unless self.start_air != ""
    self.end_air = "Not Recorded" unless self.end_air != ""
    self.conditions = "Not Recorded" unless self.conditions != ""
    self.notes = "Not Recorded" unless self.notes != ""
  end

  def total_time_in_minutes
    (self.time_out - self.time_in) / 60
  end

  def total_air_used
    self.start_air - self.end_air if start_air && end_air
  end
end