# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user

  scope :unread, -> { where(read: false) }
  scope :recent_first, -> { order(created_at: :desc) }
end
