module Account
  class BookingRequestsController < ApplicationController
    before_action :set_booking_requests

    def index
    end

    def update
      @booking_request = @booking_requests.find(params[:id])
      @booking_request.update(status: params[:booking_request][:status])

      if @booking_request.save
        flash[:notice] = "The booking request has been #{params[:booking_request][:status]}"
      else
        flash[:alert] = "An error occured, please try again."
      end

      redirect_to account_booking_requests_path
    end

    private

    def set_booking_requests
      @booking_requests = current_user.guest_requests
    end
  end
end
