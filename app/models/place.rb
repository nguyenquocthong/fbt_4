class Place < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_many :tours, dependent: :destroy

  validates :name, presence: true, length: {maximum: 50},
    uniqueness: {case_sensitive: false}

  private
  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end
