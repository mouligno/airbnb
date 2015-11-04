module ApplicationHelper
  def booking_css_class(booking)
    if booking.accepted?
      return 'label-info'
    elsif booking.rejected?
      return 'label-danger'
    elsif booking.completed?
      return 'label-success'
    elsif booking.canceled?
      return 'label-warning'
    else
      return 'label-default'
    end
  end

  def pending_travels(user)
    user.guest_requests.where(status: :pending).count
  end

  def pending_bookings(user)
    user.bookings.where(status: :pending).count
  end
end
