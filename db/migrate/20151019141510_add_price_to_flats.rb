class AddPriceToFlats < ActiveRecord::Migration
  def change
    add_column :flats, :price, :float
  end
end
