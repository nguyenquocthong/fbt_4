class Admin::BookingsController < ApplicationController
  load_and_authorize_resource

  def index
    @bookings = Booking.all
  end

  def show
  end

  def update
    if allow_status? && @booking.update_attributes(booking_params)
      flash[:success] = t "admin.bookings.change_success"
    end
    redirect_to [:admin, @booking]
  end

  private
  def booking_params
    params.require(:booking).permit :status
  end

  def allow_status?
    status = booking_params[:status]
    if @booking.waiting_pay?
      status == "disapproached" || status == "processing"
    elsif @booking.processing?
      status == "disapproached" || status == "approached"
    end
  end
end
