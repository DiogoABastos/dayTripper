class Location < ApplicationRecord
  has_many :itinerary_locations
  has_many :itineraries, through: :itinerary_locations
  has_many_attached :photos

  acts_as_taggable_on :tags

  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
end
