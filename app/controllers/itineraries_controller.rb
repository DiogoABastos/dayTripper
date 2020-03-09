class ItinerariesController < ApplicationController
  before_action :find_itinerary, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query].present?
      sql_query = " \
        itineraries.name ILIKE :query \
        OR locations.name ILIKE :query \
        OR locations.address ILIKE :query \
      "
      @itineraries = policy_scope(Itinerary).joins(:locations).where(sql_query, query: "%#{params[:query]}%")
    else
      @itineraries = policy_scope(Itinerary)
    end
  end

  def show
    @locations = @itinerary.locations
    @location = Location.new

    @markers = @locations.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { location: location })
      }
    end

    @review = Review.new
    @reviews = @itinerary.reviews
  end

  def new
    @itinerary = Itinerary.new
    authorize @itinerary
  end

  def create
    @itinerary = Itinerary.new(itinerary_params)
    authorize @itinerary
    @itinerary.duration = 0
    @itinerary.user = current_user

    if @itinerary.save
      redirect_to @itinerary
    else
      render :new
    end
  end

  def edit; end

  def update
    @itinerary.update(itinerary_params)

    redirect_to @itinerary
  end

  def destroy
    @itinerary.destroy

    redirect_to itineraries_path
  end

  def clone
    @itinerary = Itinerary.find(params[:id])
    authorize @itinerary
    @new_itinerary = @itinerary.clone_with_locations(current_user)
    redirect_to itinerary_path(@new_itinerary), notice: "Itinerary Cloned!"
  end

  private

  def itinerary_params
    params.require(:itinerary).permit(:name, :description, photos: [])
  end

  def find_itinerary
    @itinerary = Itinerary.find(params[:id])
    authorize @itinerary
  end
end
