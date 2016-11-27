class PlacesController < ApplicationController
  load_and_authorize_resource find_by: :slug

  def show
    @search = @place.tours.search params[:q]
    @tours = @search.result.joins(:place).page(params[:page]).
      per Settings.tour
    @supports = Supports::Tour.new
  end
end
