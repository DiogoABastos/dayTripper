class AddDragOrderToItineraryLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :itinerary_locations, :drag_order, :integer
  end
end
