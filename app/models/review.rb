class Review < ApplicationRecord
  include PublicActivity::Model
  tracked owner: Proc.new{|controller, model| controller.current_user}

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy, as: :likeable
  has_many :activities, as: :trackable,
    class_name: PublicActivity::Activity.name, dependent: :destroy

  belongs_to :tour
  belongs_to :user

  validates :title, presence: true, length: {minimum:10, maximum: 100}
  validates :content, presence: true, length: {minimum:200, maximum: 1000}

  scope :order_desc, -> {order created_at: :desc}
end
