class LocationsController < ApplicationController

  def show
    @itinerary = Itinerary.find(params[:itinerary_id])
    @location = Location.find(params[:id])
    authorize @location
  end
end
