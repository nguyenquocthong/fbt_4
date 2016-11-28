class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings = Booking.bookings current_user
  end
end
