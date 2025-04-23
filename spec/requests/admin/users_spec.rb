# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Admin::Users", type: :request do
  let!(:admin) { create(:user, role: :admin) }
  let!(:user) { create(:user, role: :user, active: true) }
  let!(:inactive_user) { create(:user, role: :user, active: false) }

  describe "GET /admin/users" do
    context "when logged in as admin" do
      before { sign_in admin }

      it "shows all users" do
        get admin_users_path
        expect(response).to have_http_status(:success)
        expect(response.body).to include(user.email)
        expect(response.body).to include(inactive_user.email)
      end

      it "filters by role" do
        get admin_users_path, params: { role: "admin" }
        expect(response.body).to include(admin.email)
        expect(response.body).not_to include(user.email)
      end

      it "filters by active status" do
        get admin_users_path, params: { active: "false" }
        expect(response.body).to include(inactive_user.email)
        expect(response.body).not_to include(user.email)
      end
    end

    context "when logged in as regular user" do
      before { sign_in user }

      it "redirects to root path" do
        get admin_users_path
        expect_redirect_to_path(root_path)
      end
    end
  end

  describe "PATCH /admin/users/:id/toggle_admin" do
    before { sign_in admin }

    it "toggles a user's role between admin and user" do
      patch toggle_admin_admin_user_path(user)
      expect_redirect_to_path(admin_users_path)
      expect(user.reload.role).to eq("admin")
    end
  end

  describe "PATCH /admin/users/:id/toggle_active" do
    before { sign_in admin }

    it "toggles a user's active status" do
      patch toggle_active_admin_user_path(user)
      expect_redirect_to_path(admin_users_path)
      expect(user.reload.active).to be(false)
    end
  end
end
