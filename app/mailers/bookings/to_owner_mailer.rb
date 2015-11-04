module Bookings
  class ToOwnerMailer < ApplicationMailer
    def creation(booking)
      @user = booking.flat.owner
      @booking = booking

      mail(to: @user.email, subject: 'A new booking request on your flat')
    end

    def complete(booking)
      @user = booking.flat.owner
      @booking = booking

      mail(to: @user.email, subject: 'A booking has been completed on your flat')
    end

    def cancel(booking)
      @user = booking.flat.owner
      @booking = booking

      mail(to: @user.email, subject: 'Cancel confirmation for your booking request')
    end
  end
end
