class Track < ActiveRecord::Base
  BONUS_OR_REGULAR = ["bonus", "regular"]

  belongs_to :album
end
