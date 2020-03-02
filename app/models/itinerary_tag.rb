class ItineraryTag < ApplicationRecord
  belongs_to :tag
  belongs_to :itinerary
end
