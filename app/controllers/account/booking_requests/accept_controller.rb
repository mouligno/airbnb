module Account
  module BookingRequests
    class AcceptController < Account::Base
      def create
        @booking_request = current_user.guest_requests.find(params[:booking_request_id])
        @booking_request.status = :accepted

        if @booking_request.save
          flash[:notice] = "Booking request accepted."
        else
          if @booking_request.errors.messages[:period]
            flash[:alert] = "You already have guest for this period."
          else
            flash[:alert] = "An error occured, please try again."
          end
        end

        redirect_to account_booking_requests_path
      end
    end
  end
end
