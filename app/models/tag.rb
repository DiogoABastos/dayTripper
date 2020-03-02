class Tag < ApplicationRecord
  has_many :itinerary_tags
  has_many :itineraries, through: :itinerary_tags
end
