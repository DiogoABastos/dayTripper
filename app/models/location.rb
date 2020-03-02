class Location < ApplicationRecord
  has_many :itinerary_locations
  has_many :itineraries, through: :itinerary_locations

end
