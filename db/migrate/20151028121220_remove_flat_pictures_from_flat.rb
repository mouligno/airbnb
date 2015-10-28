class RemoveFlatPicturesFromFlat < ActiveRecord::Migration
  def change
    remove_column :flats, :flat_pictures
  end
end
