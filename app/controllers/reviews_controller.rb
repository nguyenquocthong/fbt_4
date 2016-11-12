class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_tour

  def new
    @review = current_user.reviews.build
  end

  def create
    @review = current_user.reviews.build review_params
    @review.tour_id = @tour.id
    if @review.save
      flash[:success] = t "controller.create_review_success"
      redirect_to @tour
    else
      render :new
    end
  end

  private
  def review_params
    params.require(:review).permit :title, :content
  end

  def find_tour
    @tour = Tour.find_by id: params[:tour_id]
    if @tour.nil?
      flash[:danger] = t "controller.find_tour_fail"
      redirect_to root_path
    end
  end
end
