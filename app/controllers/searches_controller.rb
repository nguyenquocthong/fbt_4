class SearchesController < ApplicationController
  def index
    q = params[:search]
    @places = Place.search(name_cont: q).result
    @tours = Tour.search(name_cont: q).result
      .includes(:place)
  end
end
