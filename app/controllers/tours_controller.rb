class ToursController < ApplicationController
  load_and_authorize_resource

  def show
    @reviews = @tour.reviews
  end
end
