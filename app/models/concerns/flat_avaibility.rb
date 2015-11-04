module FlatAvaibility
  extend ActiveSupport::Concern

  def past?(date, ref_date = Date.today)
    date < ref_date
  end

  def in_period?(date, booking, start_date = true)
    flat_bookings = Flat.find(booking.flat).bookings.booked
    flat_bookings.each do |flat_booking|
      next if flat_booking == booking
      if start_date
        return false if
          date.between?(flat_booking.start_date, flat_booking.end_date - 1)
      else
        return false if
          date.between?(booking.start_date - 1, booking.end_date)
      end
    end
  end

  def over_period?(booking)
    flat_bookings = Flat.find(booking.flat).bookings.booked
    flat_bookings.each do |flat_booking|
      next if flat_booking == flat_booking
      return false if
        booking.start_date < flat_booking.start_date && end_date > flat_booking.end_date
    end
  end
end
