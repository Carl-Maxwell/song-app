class Track < ActiveRecord::Base
  BONUS_OR_REGULAR = ["bonus", "regular"]

  belongs_to :album
  has_many :notes

  validates :bonus_or_regular, inclusion: BONUS_OR_REGULAR
  validates :album_id, presence: true
end
