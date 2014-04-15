class Dive < ActiveRecord::Base
  has_many :fish, through: :dive_fishes
  has_many :dive_fishes
  belongs_to :operator
  has_many :divers, through: :diver_dives
  has_many :diver_dives
  has_many :photos

  accepts_nested_attributes_for :photos, :allow_destroy => true

  validates_presence_of :date, :dive_site
  validate :time_in_must_be_before_time_out


  validates :start_air, :end_air, :visibility, numericality: true, :allow_nil => true
  validates :depth, :temperature, numericality: { only_integer: true }, :allow_nil => true

  before_save :set_defaults

  def display_date 
    date.strftime("%B %e, %Y")
  end

  def display_time_in
    time_in.strftime("%I:%M %p")
  end

  def display_time_out
    time_out.strftime("%I:%M %p")
  end

  protected

  def set_defaults
    self.notes = "No Notes Recorded" if self.notes == nil
  end


  def time_in_must_be_before_time_out
    if time_in && time_out
      errors.add(:time_in, "must be before end time") unless
        time_in < time_out
    end
  end 

end