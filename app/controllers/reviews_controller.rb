class ReviewsController < ApplicationController
  load_and_authorize_resource :tour, find_by: :slug
  load_and_authorize_resource 

  before_action :authenticate_user!

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
    @comment = if user_signed_in?
      current_user.comments.build
    else
      Comment.new
    end
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
end
