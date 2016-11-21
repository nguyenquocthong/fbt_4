class Booking < ApplicationRecord
  attr_accessor :public_token

  belongs_to :discount
  belongs_to :tour
  belongs_to :user

  enum status: [:waiting_pay, :processing, :disapproached, :approached]
  
  validates :tour_id, presence: true, format: {with: /\A[1-9]/i}
  validates :number_member, presence: true, format: {with: /\A[1-9]/i}
  validate :available_tour

  def available_tour
    @tour = Tour.find_by_id tour_id
    if @tour
      self.total_money = number_member * @tour.price
      self.payment_token = Booking.new_token
    else
      errors.add :base, I18n.t("tours.invalid_tour")
    end
  end

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end
