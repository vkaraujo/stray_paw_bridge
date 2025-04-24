# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :adoption_request, optional: true

  scope :unread, -> { where(read: false) }
  scope :recent_first, -> { order(created_at: :desc) }
end
