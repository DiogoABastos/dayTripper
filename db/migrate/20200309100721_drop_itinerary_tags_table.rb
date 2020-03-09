class DropItineraryTagsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :itinerary_tags
  end
end
