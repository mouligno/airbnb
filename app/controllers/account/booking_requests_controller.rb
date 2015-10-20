module Account
  class BookingRequestsController < ApplicationController
    def index
      @booking_requests = BookingRequest.joins(:flat).where(flats: { owner_id: current_user.id })
    end

    def update
      @booking_request = BookingRequest.find(params[:id])
      @booking_request.update(status: params[:booking_request][:status])

      if @booking_request.valid?
        flash[:notice] = "The booking request has been #{params[:booking_request][:status]}"
        BookingRequestMailer.notify_requester(@booking_request).deliver_now
        @booking_request.save
      else
        flash[:alert] = "An error occured, please try again."
      end

      redirect_to account_booking_requests_path
    end
  end
end
