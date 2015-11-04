module Account
  module Travels
    class PaymentController < Account::Base
      def create
        @travel = current_user.bookings.find(params[:travel_id])

        if @travel.save && @travel.may_complete?
          flash[:notice] = "Your payment is completed. Have a good stay."
          @travel.complete!
        else
          flash[:alert] = "An error occured, please try again."
        end

        redirect_to account_travels_path
      end
    end
  end
end
