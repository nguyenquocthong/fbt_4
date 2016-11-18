class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review

  has_many :likes, dependent: :destroy, as: :likeable

  validates :user, presence: true
  validates :review, presence: true
  validates :content, length: {maximum: 200}

  has_closure_tree dependent: :destroy
  acts_as_tree order: "created_at DESC"
end
