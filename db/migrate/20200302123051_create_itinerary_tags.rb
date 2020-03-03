class CreateItineraryTags < ActiveRecord::Migration[5.2]
  def change
    create_table :itinerary_tags do |t|

      t.references :itinerary
      t.references :tag

      t.timestamps
    end
  end
end
