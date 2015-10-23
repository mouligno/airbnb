class FlatsController < ApplicationController
  def index
    if params[:search]
      @flats_marker = Flat.near("#{params[:search]}", 10)
      @flats        = Flat.near("#{params[:search]}", 10).page params[:page]
    else
      @flats_marker = Flat.all
      @flats = Flat.all.page params[:page]
    end

    @markers = Gmaps4rails.build_markers(@flats_marker) do |flat, marker|
      marker.lat        flat.latitude
      marker.lng        flat.longitude
      marker.infowindow render_to_string(partial: 'map_flat_box', locals: {flat: flat})
    end
  end

  def show
    @flat = Flat.find(params[:id])
  end
end
