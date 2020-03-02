class CreateItineraryLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :itinerary_locations do |t|
      t.references :location, foreign_key: true
      t.references :itinerary, foreign_key: true

      t.timestamps
    end
  end
end
