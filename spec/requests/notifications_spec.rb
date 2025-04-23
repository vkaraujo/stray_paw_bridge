# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe "PATCH /notifications/:id/mark_as_read" do
    context "when the user owns the notification" do
      let!(:notification) { create(:notification, user: user, read: false) }

      before { sign_in user }

      it "marks the notification as read" do
        patch mark_as_read_notification_path(notification)
        expect(notification.reload.read).to be true
        expect(URI.parse(response.location).path).to eq(dashboard_path)
      end
    end

    context "when the user does not own the notification" do
      let!(:notification) { create(:notification, user: other_user, read: false) }

      before { sign_in user }

      it "does not update the notification and redirects" do
        patch mark_as_read_notification_path(notification)
        expect(notification.reload.read).to be false
        expect(URI.parse(response.location).path).to eq(dashboard_path)
      end
    end

    context "when not authenticated" do
      let!(:notification) { create(:notification, user: user) }

      it "redirects to login" do
        patch mark_as_read_notification_path(notification)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
