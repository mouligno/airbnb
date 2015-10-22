module ApplicationHelper
  def booking_request_css_class(booking_request)
    if booking_request.status.accepted?
      return 'label-success'
    elsif booking_request.status.rejected?
      return 'label-danger'
    else
      return 'label-default'
    end
  end

  def pending_guest_requests(user)
    user.guest_requests.where(status: :pending).count
  end

  def pending_booking_requests(user)
    user.booking_requests.where(status: :pending).count
  end
end
