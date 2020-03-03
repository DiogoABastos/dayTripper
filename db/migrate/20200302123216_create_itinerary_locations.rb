class CreateItineraryLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :itinerary_locations do |t|
      t.references :location
      t.references :itinerary

      t.timestamps
    end
  end
end
