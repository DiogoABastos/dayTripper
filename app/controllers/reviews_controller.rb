class ReviewsController < ApplicationController

  def new
    @review = Review.new

    authorize @review
  end

  def create
    @review = Review.new(review_params)
    @itinerary = Itinerary.find(params[:itinerary_id])

    @review.user = current_user
    @review.itinerary = @itinerary

    authorize @review

    if @review.save
      respond_to do |format|
        format.html { redirect_to itinerary_path(@itinerary) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'itineraries/review' }
        format.js
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:description, :rating)
  end
end
