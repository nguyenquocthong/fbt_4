class Booking < ApplicationRecord
  belongs_to :discount
  belongs_to :tour
  belongs_to :user
end
