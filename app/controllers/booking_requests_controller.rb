class BookingRequestsController < ApplicationController
  before_action :authenticate_user!

  def new
    @flat = Flat.find(params[:flat_id])
    @booking_request = @flat.booking_requests.build(requester_id: current_user.id)
  end

  def create
    @flat = Flat.find(params[:flat_id])
    @booking_request = @flat.booking_requests.build(requester: current_user)
    @booking_request.update(booking_request_params)

    if @booking_request.save
      flash[:notice] = "Booking request successfully created."
      redirect_to account_travels_path
    else
      if @booking_request.errors.messages[:requester]
        flash[:alert] = "You can't book your own flat."
      else
        flash[:alert] = "A problem occured saving your request."
      end
      render :new
    end
  end

private
  def booking_request_params
    params.require(:booking_request).permit(:description)
  end
end
