class Itinerary < ApplicationRecord
  belongs_to :user
  has_many :reviews

  has_many :itinerary_locations
  has_many :locations, through: :itinerary_locations

  has_one_attached :photo

  # include PgSearch::Model
  # multisearchable against: [:name]

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :name ],
    associated_against: {
      locations: [ :name, :address ]
    },
    using: {
      tsearch: { prefix: true }
    }

  def markers_method
      self.locations.map do |location|
        {
          "lat" => location.latitude,
          "lng" => location.longitude
        }
      end
  end


  def self.tagged_with(word)
    locations = Location.tagged_with(word)
    return [] if locations.empty?

    locations.map do |loc|
      loc.itineraries
    end.uniq.flatten

  end

  def clone_with_locations(user)
    attr = self.attributes
    attr = attr.except("id", "user_id", "created_at", "updated_at")
    new_itinerary = Itinerary.new(attr)
    new_itinerary.user = user
    new_itinerary.name = "**COPY OF " + new_itinerary.name + "**"
    new_itinerary.photo = self.photo.blob
    new_itinerary.save

    locs = self.locations.map do |loc|
      loc_attr = loc.attributes


      loc_attr = loc_attr.except("id", "created_at", "updated_at")
      new_location = Location.new(loc_attr)
      loc.tag_list.each do |tag|
        new_location.tag_list.add(tag)
      end
      new_location.save

      if loc.photos.attached?
        loc.photos.each do |ph|
          new_location.photos.attach(ph.blob)
        end
      end

      ItineraryLocation.create(location: new_location, itinerary: new_itinerary)
    end

    new_itinerary
  end

end

