module DiveHelper
  def record(attribute)
    attribute ? attribute : "Not Recorded"
  end
end