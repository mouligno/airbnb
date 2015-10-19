class FlatsController < ApplicationController
  def index
    @flats = Flat.all
  end

  def show
    @flat = Flat.find(params[:id])
  end

  def new
    @flat = current_user.flats.build
  end

  def create
    @flat = current_user.flats.build(flat_params)

    if @flat.valid?
      @flat.save
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
                                {flat_pictures: []})
  end
end
