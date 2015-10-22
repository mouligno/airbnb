module Account
  class BookingRequestsController < Base
    before_action :set_booking_requests

    def index
    end

  private

    def set_booking_requests
      @booking_requests = current_user.guest_requests.order(start_date: :asc)
    end
  end
end
