module Account
  class BookingsController < Base
    before_action :set_bookings

    def index
    end

  private

    def set_bookings
      @bookings = current_user.guest_requests.order(start_date: :asc)
    end
  end
end
