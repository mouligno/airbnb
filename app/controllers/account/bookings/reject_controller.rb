module Account
  module Bookings
    class RejectController < Account::Base
      def create
        @booking = current_user.guest_requests.find(params[:booking_id])

        if @booking.may_reject?
          flash[:notice] = "Booking request rejected."
          @booking.reject!
        else
          raise
          flash[:alert] = "An error occured, please try again."
        end

        redirect_to account_bookings_path
      end
    end
  end
end
