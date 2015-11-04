module Account
  module Travels
    class CancelController < Account::Base
      def create
        @travel = current_user.bookings.find(params[:travel_id])

        if @travel.save && @travel.may_cancel?
          flash[:notice] = "You're booking request has been canceled."
          @travel.cancel!
        else
          flash[:alert] = "An error occured, please try again."
        end

        redirect_to account_travels_path
      end
    end
  end
end
