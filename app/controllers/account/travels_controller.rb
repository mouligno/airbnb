module Account
  class TravelsController < Base
    def index
      @travels = current_user.booking_requests.order(start_date: :asc)
    end
  end
end
