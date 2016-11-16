class PlacesController < ApplicationController
  load_and_authorize_resource

  def show
    @tours = @place.tours.page(params[:page]).per Settings.tour
    @supports = Supports::Tour.new
  end
end
