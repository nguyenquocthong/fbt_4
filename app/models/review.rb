class Review < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy, as: :likeable

  belongs_to :tour
  belongs_to :user

  validates :title, presence: true, length: {minimum:10, maximum: 100}
  validates :content, presence: true, length: {minimum:200, maximum: 1000}

  scope :order_desc, -> {order created_at: :desc}
end
