class LocationsController < ApplicationController
  before_action :find_itinerary
  before_action :find_location, except: [:new, :create]

  def show
    if @location.geocoded?
    @markers =
       {
        lat: @location.latitude,
        lng: @location.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { location: @location })
       }
     else
      @default_location = Location.geocoded.first
      @markers = {
        lat: @default_location.latitude,
        lng: @default_location.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { location: @location })
      }
    end
  end

  def new
    @location = Location.new
    authorize @location
  end

  def create
    @location = Location.new(location_params)


    @location.itineraries << @itinerary
    @itinerary.duration += @location.duration

    authorize @location

    if @location.save
      respond_to do |format|
        format.html { redirect_to itinerary_path(@itinerary) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'itineraries/location' }
        format.js
      end
    end
  end

  def edit; end

  def update
    if @location.update(location_params)
      redirect_to @itinerary
    else
      render :edit
    end
  end

  def destroy
    @location.destroy

  end

  private

  def location_params
    params.require(:location).permit(:name, :address, :description, :category, :duration, photos: [])
  end

  def find_itinerary
    @itinerary = Itinerary.find(params[:itinerary_id])
  end

  def find_location
    @location = Location.find(params[:id])
    authorize @location
  end
end
