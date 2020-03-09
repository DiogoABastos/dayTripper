class Itinerary < ApplicationRecord
  belongs_to :user
  has_many :reviews

  has_many :itinerary_tags
  has_many :tags, through: :itinerary_tags

  has_many :itinerary_locations
  has_many :locations, through: :itinerary_locations

  has_many_attached :photos

  def markers_method
      self.locations.map do |location|
        {
          "lat" => location.latitude,
          "lng" => location.longitude
        }
      end
  end

  def clone_with_locations(user)
    attr = self.attributes
    attr = attr.except("id", "user_id", "created_at", "updated_at")
    new_itinerary = Itinerary.new(attr)
    new_itinerary.user = user
    new_itinerary.name = "**COPY OF " + new_itinerary.name + "**"
    new_itinerary.save

    self.locations.each do |loc|
      loc_attr = loc.attributes
      loc_attr = loc_attr.except("id", "created_at", "updated_at")
      new_location = Location.new(loc_attr)
      new_location.save

      loc.itinerary_locations.each do |itinerary_loc|
        new_itinerary_location = ItineraryLocation.new
        new_itinerary_location.location = new_location
        new_itinerary_location.itinerary = new_itinerary
        new_itinerary_location.save
      end
    end
    new_itinerary
  end

end

