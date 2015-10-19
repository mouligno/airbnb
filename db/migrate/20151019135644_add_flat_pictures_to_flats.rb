class AddFlatPicturesToFlats < ActiveRecord::Migration
  def change
    add_column :flats, :flat_pictures, :json
  end
end
