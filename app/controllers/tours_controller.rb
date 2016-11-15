class ToursController < ApplicationController
  load_and_authorize_resource

  def index
    @tours = Tour.page(params[:page]).per Settings.tour
    @supports = Supports::Tour.new
  end

  def show
    @reviews = @tour.reviews.order_desc
  end
end
