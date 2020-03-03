class LocationsController < ApplicationController
  before_action :find_itinerary

  def show
    @location = Location.find(params[:id])
    authorize @location

    if @location
    @markers =
       {
        lat: @location.latitude,
        lng: @location.longitude,
       }
    end
  end

  def new
    @location = Location.new
    authorize @location
  end

  def create
    @location = Location.new(location_params)
    authorize @itinerary

    @location.itineraries << @itinerary
    @itinerary.duration += @location.duration

    if @location.save
      redirect_to @itinerary
    else
      render :new
    end
  end

  private

  def location_params
    params.require(:location).permit(:name, :address, :description, :category, :duration)
  end

  def find_itinerary
    @itinerary = Itinerary.find(params[:itinerary_id])
  end
end
