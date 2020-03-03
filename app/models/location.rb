class Location < ApplicationRecord
  has_many :itinerary_locations
  has_many :itineraries, through: :itinerary_locations

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
