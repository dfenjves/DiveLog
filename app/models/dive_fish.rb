class DiveFish < ActiveRecord::Base
  belongs_to :dive
  belongs_to :fish
end
