module Account
  module Travels
    class CancelController < Account::Base
      def create
        @travel = current_user.booking_requests.find(params[:travel_id])
        @travel.status = :canceled

        if @travel.save
          flash[:notice] = "You're booking request has been canceled."
        else
          flash[:alert] = "An error occured, please try again."
        end

        redirect_to account_travels_path
      end
    end
  end
end
