class RemoveDragOrderFromLocations < ActiveRecord::Migration[5.2]
  def change
    remove_column :locations, :drag_order, :string
  end
end
