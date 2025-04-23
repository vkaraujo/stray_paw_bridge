# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "scopes" do
    let!(:user) { create(:user) }
    let!(:read_notification) { create(:notification, user:, read: true, created_at: 1.day.ago) }
    let!(:unread_notification) { create(:notification, user:, read: false, created_at: Time.current) }

    it "returns only unread notifications" do
      expect(Notification.unread).to match_array([unread_notification])
    end

    it "orders notifications with newest first" do
      expect(Notification.recent_first.first).to eq(unread_notification)
    end
  end
end
