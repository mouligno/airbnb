module Account
  class TravelsController < ApplicationController
    def index
      @travels = current_user.booking_requests
    end
  end
end
