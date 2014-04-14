class Dive < ActiveRecord::Base
  has_many :fish, through: :dive_fishes
  has_many :dive_fishes
  belongs_to :operator
  has_many :divers, through: :diver_dives
  has_many :diver_dives
  has_many :photos

  accepts_nested_attributes_for :photos, :allow_destroy => true
  accepts_nested_attributes_for :fish

  validates_presence_of :time_in, :time_out, :date, :dive_site

  validates :start_air, :end_air, numericality: true, :allow_nil => true
  validates :depth, :temperature, numericality: { only_integer: true }, :allow_nil => true

  before_save :set_defaults

  def total_time_in_minutes
    ((self.time_out - self.time_in) / 60).to_i
  end

  def display_date 
    date.strftime("%B %d, %Y")
  end

  def display_time_in
    time_in.strftime("%I:%M %p")
  end

  def display_time_out
    time_out.strftime("%I:%M %p")
  end

  def fish_name
    fish.try(:name)
  end

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






