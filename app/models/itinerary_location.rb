class ItineraryLocation < ApplicationRecord
  belongs_to :location
  belongs_to :itinerary
end
