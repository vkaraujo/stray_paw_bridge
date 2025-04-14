# frozen_string_literal: true

class Pet < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  enum status: { available: 0, pending: 1, adopted: 2 }
  enum species: { dog: 0, cat: 1 }

  validates :name, :species, :size, :status, presence: true
end
