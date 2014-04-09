class Dive < ActiveRecord::Base
  has_many :fish, through: :divefishes
  has_many :divefishes
  belongs_to :operator
  has_many :divers, through: :diver_dives
  has_many :diver_dives
  has_many :photos

  accepts_nested_attributes_for :photos, :allow_destroy => true

  validates_presence_of :time_in, :time_out, :date, :dive_site
  before_save :set_defaults

  def total_time_in_minutes
    ((self.time_out - self.time_in) / 60).to_i
  end

  def total_air_used
    self.start_air - self.end_air if start_air && end_air
  end

  protected

  def set_defaults
    self.conditions = "Not Recorded" if self.conditions == ""
    self.notes = "No Notes Recorded" if self.notes == ""
  end  

end