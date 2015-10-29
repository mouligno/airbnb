module Account
  module Travels
    class PaymentController < Account::Base
      def create
        @travel = current_user.booking_requests.find(params[:travel_id])
        @travel.status = :completed

        if @travel.save
          flash[:notice] = "Your payment is completed. Have a good stay."
        else
          flash[:alert] = "An error occured, please try again."
        end

        redirect_to account_travels_path
      end
    end
  end
end
