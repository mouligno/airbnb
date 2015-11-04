class UpdateStatusForBookings < ActiveRecord::Migration
  def change
    remove_column :bookings, :status
    add_column :bookings, :status, :string
  end
end
