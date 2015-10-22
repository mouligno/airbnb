module Account
  module BookingRequests
    class RejectController < Account::Base
      def create
        @booking_request = current_user.guest_requests.find(params[:booking_request_id])
        @booking_request.status = :rejected

        if @booking_request.save
          flash[:notice] = "Booking request rejected."
        else
          flash[:alert] = "An error occured, please try again."
        end

        redirect_to account_booking_requests_path
      end
    end
  end
end
