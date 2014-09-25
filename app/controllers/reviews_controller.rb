class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new,
                                            :create,
                                            :destroy,
                                            :edit,
                                            :update]

  def new
    @bus = Bus.find(params[:bus_id])
    @rides = @bus.rides
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @bus = @review.ride.bus

    if @review.save
      redirect_to bus_path(@bus), notice: "Review successfully created."
    else
      render "new"
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])

    if @review.update(review_params)
      redirect_to @review, notice: "Review successfully updated."
    else
      render "edit"
    end
  end
end

private

def review_params
  params.require(:review).permit(
    :ride_id,
    :rating,
    :body
  ).merge(user: current_user)
end
