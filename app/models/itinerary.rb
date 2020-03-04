class Itinerary < ApplicationRecord
  belongs_to :user
  has_many :reviews

  has_many :itinerary_tags
  has_many :tags, through: :itinerary_tags

  has_many :itinerary_locations
  has_many :locations, through: :itinerary_locations
  has_many_attached :photos
end
