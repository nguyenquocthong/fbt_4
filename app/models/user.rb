class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: [:facebook]
  has_many :activities, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :bank_accounts, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  enum role: [:user, :admin, :guess]

  ratyrate_rater

  class << self
    def from_omniauth token
      data = token.info
      user = User.find_by email: data["email"]
      unless user
        password = Devise.friendly_token[0,20]
        user = User.create name: data["name"], email: data["email"],
          gravatar: data["image"], password: password,
          password_confirmation: password
      end
      user
    end
  end

  def like? target
    like = target.likes.find_by user_id: self.id
  end
end
