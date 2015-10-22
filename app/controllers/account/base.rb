module Account
  class Base < ApplicationController
    before_action :authenticate_user!
  end
end
