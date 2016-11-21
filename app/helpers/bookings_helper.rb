module BookingsHelper
  def status_select_params book
    if book.waiting_pay?
      hash_to_array Booking.statuses.except(:approached)
    elsif book.processing?
      hash_to_array Booking.statuses.except(:waiting_pay)
    end
  end

  def hash_to_array hash
    hash.collect{|key, value| [key, key]}
  end

  def is_change_status book
    book.waiting_pay? || book.processing?
  end
end
