# frozen_string_literal: true

class Pet < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  enum status: { available: 0, pending: 1, adopted: 2 }
  enum species: { dog: 0, cat: 1 }

  validates :name, :species, :size, :status, presence: true

  has_many :adoption_requests, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  scope :available, -> { where(status: :available) }
end
