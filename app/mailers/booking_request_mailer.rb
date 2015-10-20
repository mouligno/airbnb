class BookingRequestMailer < ApplicationMailer
  def notify_owner(booking_request)
    @user = booking_request.flat.owner  # Instance variable => available in view
    @booking_request = booking_request

    mail(to: @user.email, subject: 'A new booking request on your flat')
  end

  def notify_requester(booking_request)
    @user = booking_request.requester  # Instance variable => available in view
    @booking_request = booking_request

    mail(to: @user.email, subject: 'Your booking request has been accepted.')
  end

end
