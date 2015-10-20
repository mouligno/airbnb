class ChangeDefaultStatusForBookingRequests < ActiveRecord::Migration
  def change
    change_column_default(:booking_requests, :status, 'pending')
  end
end
