module Account
  class TravelsController < Base
    def index
      @travels = current_user.bookings.order(start_date: :asc)
    end

    def show
      @travel = current_user.bookings.find(params[:id])
    end
  end
end
