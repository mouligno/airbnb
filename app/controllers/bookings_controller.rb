class BookingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @flat = Flat.find(params[:flat_id])
    @booking = @flat.bookings.build(requester_id: current_user.id)
  end

  def create
    @flat = Flat.find(params[:flat_id])

    @booking = @flat.bookings.build(requester: current_user)
    @booking.update(booking_params)

    if @booking.save
      flash[:notice] = "Booking request successfully created."

      ::Bookings::ToRequesterMailer.creation(@booking).deliver_now
      ::Bookings::ToOwnerMailer.creation(@booking).deliver_now

      redirect_to account_travels_path
    else
      if @booking.errors.messages[:requester]
        flash[:alert] = "You can't book your own flat."
      elsif @booking.errors.messages[:period]
        flash[:alert] = "This flat has already been booked for this period."
      else
        flash[:alert] = "A problem occured saving your request."
      end
      render :new
    end
  end

private
  def booking_params
    params.require(:booking).permit(:description, :start_date, :end_date)
  end
end
