class Place < ApplicationRecord
  has_many :tours, dependent: :destroy

  validates :name, presence: true, length: {maximum: 50},
    uniqueness: {case_sensitive: false}
end
