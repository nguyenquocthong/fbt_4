class ToursController < ApplicationController
  load_and_authorize_resource find_by: :slug

  def index
    @search = Tour.search params[:q]
    @tours = if params[:tag]
      Tour.tagged_with params[:tag]
    else
      @search.result.joins(:place).page(params[:page]).per Settings.tour
    end
    @supports = Supports::Tour.new
  end

  def show
    @reviews = @tour.reviews.order_desc
    if user_signed_in?
      @comment = current_user.comments.build
    end
  end
end
