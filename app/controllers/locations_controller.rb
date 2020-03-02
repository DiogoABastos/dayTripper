class LocationsController < ApplicationController

  def show
    @location = Location.find(params[:itinerary_id])
    @itinerary = Itinerary.find(params[:id])
    authorize @location
  end
end
