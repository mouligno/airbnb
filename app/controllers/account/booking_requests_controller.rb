module Account
  class BookingRequestsController < ApplicationController
    def index
      @booking_requests = BookingRequest.joins(:flat).where(flats: { owner_id: current_user.id })
    end
  end
end
