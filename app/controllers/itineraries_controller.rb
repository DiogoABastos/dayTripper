class ItinerariesController < ApplicationController
  before_action :find_itinerary, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query].present?

      @itineraries_global = policy_scope(Itinerary).global_search(params[:query])

      @itineraries_by_tag = policy_scope(Itinerary).tagged_with(params[:query])

      @itineraries = (@itineraries_global + @itineraries_by_tag).uniq
      # sql_query = " \
      #   itineraries.name ILIKE :query \
      #   OR locations.name ILIKE :query \
      #   OR locations.address ILIKE :query \
      # "
      # @itineraries = policy_scope(Itinerary).joins(:locations).where(sql_query, query: "%#{params[:query]}%").uniq
    else
      @itineraries = policy_scope(Itinerary)
    end
  end

  def show
    @skip_footer = true

    @locations = @itinerary.locations.order("itinerary_locations.drag_order ASC")

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
    redirect_to edit_itinerary_path(@new_itinerary), notice: "Itinerary Cloned!"
  end

  private

  def itinerary_params
    params.require(:itinerary).permit(:name, :description, :photo)
  end

  def find_itinerary
    @itinerary = Itinerary.find(params[:id])
    authorize @itinerary
  end
end
