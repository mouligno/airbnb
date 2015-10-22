module Account
  class TravelsController < Base
    def index
      @travels = current_user.booking_requests
    end
  end
end
