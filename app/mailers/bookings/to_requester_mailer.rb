module Bookings
  class ToRequesterMailer < ApplicationMailer
    def creation(booking)
      @user = booking.requester
      @booking = booking

      mail(to: @user.email, subject: 'Your booking request has been created.')
    end

    def accept(booking)
      @user = booking.requester
      @booking = booking

      mail(to: @user.email, subject: 'Your booking request has been accepted.')
    end

    def reject(booking)
      @user = booking.requester
      @booking = booking

      mail(to: @user.email, subject: 'Your booking request has been rejected.')
    end

    def complete(booking)
      @user = booking.flat.requester
      @booking = booking

      mail(to: @user.email, subject: 'Your booking has been completed')
    end

    def cancel(booking)
      @user = booking.requester
      @booking = booking

      mail(to: @user.email, subject: 'Cancel confirmation for your booking request')
    end
  end
end
