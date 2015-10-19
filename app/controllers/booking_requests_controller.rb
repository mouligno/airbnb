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

    if @booking_request.valid?
      flash[:notice] = "Booking request successfully created."
      @booking_request.save
      redirect_to root_path
    else
      flash[:alert] = "A problem occured saving your request."
      render :new
    end
  end

private
  def booking_request_params
    params.require(:booking_request).permit(:description)
  end
end
