class AddAvaibilitiesOnBookingRequests < ActiveRecord::Migration
  def change
    add_column :booking_requests, :start_date,  :date
    add_column :booking_requests, :end_date,    :date
  end
end
