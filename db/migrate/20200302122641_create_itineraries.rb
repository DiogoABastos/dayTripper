class CreateItineraries < ActiveRecord::Migration[5.2]
  def change
    create_table :itineraries do |t|

      t.text :description
      t.datetime :duration

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
