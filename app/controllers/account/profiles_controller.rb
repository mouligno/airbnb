module Account
  class ProfilesController < ApplicationController
    before_action :set_profile

    def show
    end

    def edit
    end

    def update
      @profile.update(profile_params)

      redirect_to account_profile_path
    end

  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :description, :profile_picture)
    end

    def set_profile
      @profile = current_user.profile || current_user.build_profile
    end
  end
end
