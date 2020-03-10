class Itinerary < ApplicationRecord
  belongs_to :user
  has_many :reviews

  has_many :itinerary_locations
  has_many :locations, through: :itinerary_locations

  has_one_attached :photo

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

    locs = self.locations.map do |loc|
      loc_attr = loc.attributes
      loc_attr = loc_attr.except("id", "created_at", "updated_at")
      new_location = Location.new(loc_attr)
      loc.tag_list.each do |tag|
        new_location.tag_list.add(tag)
      end
      new_location.save

      ItineraryLocation.create(location: new_location, itinerary: new_itinerary)

      # loc.itinerary_locations.each do |itinerary_loc|
      #   new_itinerary_location = ItineraryLocation.new
      #   new_itinerary_location.location = new_location
      #   new_itinerary_location.itinerary = new_itinerary
      #   new_itinerary_location.save
      # end
    end
    # new_itinerary.locations << locs

    new_itinerary
  end

end

