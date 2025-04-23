# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Admin::Pets", type: :request do
  let!(:admin) { create(:user, role: :admin) }
  let!(:user) { create(:user) }
  let!(:visible_pet) { create(:pet, user: user, visible: true) }
  let!(:hidden_pet) { create(:pet, user: user, visible: false) }

  describe "GET /admin/pets" do
    context "as admin" do
      before { sign_in admin }

      it "renders successfully with all pets" do
        get admin_pets_path
        expect(response).to have_http_status(:success)
        expect(response.body).to include(visible_pet.name)
        expect(response.body).to include(hidden_pet.name)
      end
    end

    context "as non-admin" do
      before { sign_in user }

      it "redirects to root path" do
        get admin_pets_path
        expect_redirect_to_path(root_path)
      end
    end
  end

  describe "PATCH /admin/pets/:id/toggle_visibility" do
    context "as admin" do
      before { sign_in admin }

      it "toggles visibility from true to false" do
        patch toggle_visibility_admin_pet_path(visible_pet)
        expect_redirect_to_path(admin_pets_path)
        expect(visible_pet.reload.visible).to be(false)
      end

      it "toggles visibility from false to true" do
        patch toggle_visibility_admin_pet_path(hidden_pet)
        expect_redirect_to_path(admin_pets_path)
        expect(hidden_pet.reload.visible).to be(true)
      end
    end

    context "as non-admin" do
      before { sign_in user }

      it "redirects to root path" do
        patch toggle_visibility_admin_pet_path(visible_pet)
        expect_redirect_to_path(root_path)
        expect(visible_pet.reload.visible).to be(true)
      end
    end
  end
end
