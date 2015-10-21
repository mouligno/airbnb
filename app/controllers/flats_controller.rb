class FlatsController < ApplicationController
  def index
    if params[:search]
      @flats = Flat.near("#{params[:search]}", 10)
    else
      @flats = Flat.all
    end

    @markers = Gmaps4rails.build_markers(@flats) do |flat, marker|
      marker.lat flat.latitude
      marker.lng flat.longitude
    end
  end

  def show
    @flat = Flat.find(params[:id])
  end
end
