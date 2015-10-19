class CreateBookingRequests < ActiveRecord::Migration
  def change
    create_table :booking_requests do |t|
      t.references :flat, index: true, foreign_key: true
      t.integer :requester_id, index: true
      t.text :description
      t.string :status

      t.timestamps null: false
    end

    add_foreign_key :booking_requests, :users, column: :requester_id
  end
end
