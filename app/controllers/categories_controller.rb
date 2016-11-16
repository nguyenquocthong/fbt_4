class CategoriesController < ApplicationController
  load_and_authorize_resource
  
  def show
    @tours = @category.tours.page(params[:page]).per Settings.tour
    @supports = Supports::Tour.new
  end
end
