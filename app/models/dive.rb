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

  # ATTR_IN_METERS = [:depth, :visibility]

  def total_time_in_minutes
    ((self.time_out - self.time_in) / 60).to_i
  end

  def total_air_used
    self.start_air - self.end_air if start_air && end_air
  end

  # ATTR_IN_METERS.each do |a|
  #   define_method(a) do
  #    instance_variable_get("@#{a.to_s}") ? instance_variable_get("@#{a.to_s}").to_s + " m" : "Not Recorded" }
  #   end
  # end

  protected

  def set_defaults
    self.notes = "No Notes Recorded" if self.notes == ""
  end  

end



    # t.date     "date"
    # t.integer  "depth"
    # t.integer  "temperature"
    # t.time     "time_in"
    # t.time     "time_out"
    # t.string   "dive_site"
    # t.integer  "visibility"
    # t.integer  "start_air"
    # t.integer  "end_air"
    # t.string   "dive_type"
    # t.string   "dive_activity"
    # t.boolean  "wetsuit",       limit: 255
    # t.string   "conditions"






