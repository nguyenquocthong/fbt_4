class ReviewsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
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

  def show
  end

  def edit
  end

  def update
    if @review.update_attributes review_params
      flash[:success] = t "controller.update_success"
      redirect_to @tour
    else
      render :edit
    end
  end

  def destroy
    if @review.destroy
      flash[:success] = t "controller.destroy_success"
    else
      flash[:danger] = t "controller.destroy_fail"
    end
    redirect_to @tour
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
