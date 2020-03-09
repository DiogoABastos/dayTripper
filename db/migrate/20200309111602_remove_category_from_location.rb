class RemoveCategoryFromLocation < ActiveRecord::Migration[5.2]
  def change
    remove_column :locations, :category
  end
end
