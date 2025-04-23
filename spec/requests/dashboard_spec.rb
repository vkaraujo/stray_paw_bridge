# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Dashboard", type: :request do
  let(:user) { create(:user) }
  let!(:pet1) { create(:pet, user: user, name: "Tango") }
  let!(:pet2) { create(:pet, user: user, name: "Whiskers") }

  describe "GET /dashboard" do
    before do
      sign_in user
      create_list(:pet, 2, user: user)
      create_list(:adoption_request, 3, user: user)
      create_list(:notification, 4, user: user)
      get dashboard_path
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "displays user's pets" do
      expect(response.body).to include("Tango")
      expect(response.body).to include("Whiskers")
    end

    it "displays user's adoption requests" do
      expect(response.body).to include(AdoptionRequest.first.pet.name)
    end

    it "displays user's notifications" do
      expect(response.body).to include(Notification.first.message)
    end
  end

  describe "authentication" do
    it "redirects unauthenticated users to login" do
      get dashboard_path
      expect_redirect_to_path(new_user_session_path)
    end
  end
end
