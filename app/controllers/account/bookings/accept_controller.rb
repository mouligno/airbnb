module Account
  module Bookings
    class AcceptController < Account::Base
      def create
        @booking = current_user.guest_requests.find(params[:booking_id])

        if @booking.may_accept?
          flash[:notice] = "Booking accepted."
          @booking.accept!
        else
          flash[:alert] = "You can't accept this request."
        end

        redirect_to account_bookings_path
      end
    end
  end
end
