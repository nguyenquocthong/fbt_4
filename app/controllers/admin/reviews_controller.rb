class Admin::ReviewsController < ApplicationController
  load_and_authorize_resource

  def index
    @reviews = Review.all.order(created_at: :desc).page params[:page]
  end

  def show
  end

  def destroy
    if @review.destroy
      flash[:success] = t "controller.destroy_success"
    else
      flash[:success] = t "controller.destroy_fail"
    end
    redirect_to admin_reviews_path
  end
end
