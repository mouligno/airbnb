class RenameBookingRequestsToBookings < ActiveRecord::Migration
  def change
    rename_table :booking_requests, :bookings
  end
end
