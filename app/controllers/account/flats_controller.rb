module Account
  class FlatsController < Base
    def new
      @flat = Flat.new
      @flat.owner = current_user
      @flat.flat_pictures.build
    end

    def create
      @flat = Flat.new(flat_params)
      @flat.owner = current_user

      if @flat.save
        flash[:notice] = 'Flat successfully saved.'
        redirect_to flat_path(@flat)
      else
        flash[:alert] = 'An error occured creating your flat.'
        render :new
      end
    end

  private
    def flat_params
      params.require(:flat).permit(:title,
                                  :address_line_1,
                                  :address_line_2,
                                  :zip_code,
                                  :city,
                                  :country,
                                  :rooms_number,
                                  :bed_number,
                                  :bathroom_number,
                                  :people_number,
                                  :price,
                                  :smoker,
                                  :television,
                                  :internet,
                                  :kind,
                                  flat_pictures_attributes: [:id, :image, :_destroy])
    end
  end
end
