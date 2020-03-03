class CreateItineraries < ActiveRecord::Migration[5.2]
  def change
    create_table :itineraries do |t|

      t.string :name
      t.text :description
      t.integer :duration

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
