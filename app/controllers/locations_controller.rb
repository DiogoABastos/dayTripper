class LocationsController < ApplicationController
  before_action :find_itinerary, except: :change_order
  before_action :find_location, except: [:new, :create, :change_order]
  before_action :skip_authorization, only: :change_order
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
      add_drag_order
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

  def change_order
    @itinerary = Itinerary.find(params["id"])
    #authorize @itinerary
    old_itinerary_loc = @itinerary.itinerary_locations.find_by(drag_order: params["old"])
    new_itinerary_loc = @itinerary.itinerary_locations.find_by(drag_order: params["new"])
    ordered_locations = @itinerary.itinerary_locations.order(:drag_order)

    old_drag_order = old_itinerary_loc.drag_order # 1
    new_drag_order = new_itinerary_loc.drag_order # 3
    # puts "---------------------------------------------------"
    # puts "OLD #{old_drag_order}"
    # puts "NEW #{new_drag_order}"

    if new_drag_order > old_drag_order
      @itinerary.itinerary_locations.order(:drag_order)[old_drag_order+1..new_drag_order].each do |elem|
        #puts "Before: #{elem.location.name} is now #{elem.drag_order}"
        # byebug
        elem.drag_order -= 1
        elem.save
        puts "After: #{elem.location.name} is now #{elem.drag_order}"
      end
      old_itinerary_loc.drag_order = new_drag_order
      old_itinerary_loc.save
      puts "End: #{old_itinerary_loc.location.name} now is #{old_itinerary_loc.drag_order}"

    elsif old_drag_order > new_drag_order
      @itinerary.itinerary_locations.order(:drag_order)[new_drag_order..old_drag_order-1].each do |elem|
        elem.drag_order += 1
        elem.save
      end
      old_itinerary_loc.drag_order = new_drag_order
      old_itinerary_loc.save
    end


    # redirect_to itinerary_path(@itinerary)
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
    params.require(:location).permit(:name, :address, :description, :duration, :tag_list, photos: [])
  end

  def find_itinerary
    @itinerary = Itinerary.find(params[:itinerary_id])
  end

  def find_location
    @location = Location.find(params[:id])
    authorize @location
  end

  def add_drag_order
    itinerary_locs = @itinerary.itinerary_locations.order(:created_at)

    if itinerary_locs.count == 1
      itinerary_locs.first.update(drag_order: 0)
    else
      last_drag_order = itinerary_locs[-2].drag_order
      last_itinerary_location = @location.itinerary_locations.last
      last_itinerary_location.drag_order = (last_drag_order + 1)
      last_itinerary_location.save
    end
  end

end
