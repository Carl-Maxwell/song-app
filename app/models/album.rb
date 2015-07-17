class Album < ActiveRecord::Base
  LIVE_OR_STUDIO = ["live", "studio"]

  belongs_to :band
  has_many :tracks

  
end
