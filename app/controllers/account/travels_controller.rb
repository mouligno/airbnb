module Account
  class TravelsController < Base
    def index
      @travels = current_user.booking_requests.order(start_date: :asc)
    end

    def show
      @travel = current_user.booking_requests.find(params[:id])
    end
  end
end
