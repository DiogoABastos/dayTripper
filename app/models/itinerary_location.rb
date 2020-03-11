class ItineraryLocation < ApplicationRecord
  belongs_to :location
  belongs_to :itinerary
  has_many_attached :photos

end
