class Admin::BookingsController < ApplicationController
  load_and_authorize_resource

  def index
    @filterrific = initialize_filterrific(
      Booking,
      params[:filterrific],
      select_options: {
        sorted_by: Booking.options_for_sorted_by,
        status: Booking.options_for_status,
      }
    ) or return
    @bookings = @filterrific.find.page params[:page]

    respond_to do |format|
      format.html
      format.js
    end
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
  def find_booking
    @book = Booking.find_by id: params[:id]
    unless @book
      flash[:danger] = t "admin.bookings.not_found"
      redirect_to root_path
    end
  end

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
