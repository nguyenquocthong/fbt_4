class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @activities = Activity.order_desc
  end
end
