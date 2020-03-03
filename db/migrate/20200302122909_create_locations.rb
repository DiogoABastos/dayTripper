class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.text :description
      t.string :category
      t.integer :duration

      t.timestamps
    end
  end
end
