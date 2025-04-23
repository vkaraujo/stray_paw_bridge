# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "AdoptionRequests", type: :request do
  include ActiveJob::TestHelper

  let(:rescuer) { create(:user) }
  let(:adopter) { create(:user) }
  let(:admin)   { create(:user, role: :admin) }
  let(:pet)     { create(:pet, user: rescuer) }

  describe "POST /adoption_requests" do
    before { sign_in adopter }

    it "creates a new adoption request" do
      expect {
        post adoption_requests_path, params: { adoption_request: { pet_id: pet.id, message: "Please let me adopt!" } }
      }.to change(AdoptionRequest, :count).by(1)

      expect_redirect_to_path(pet_path(pet))
    end
  end

  describe "PATCH /adoption_requests/:id/approve" do
    let!(:request_record) { create(:adoption_request, user: adopter, pet: pet) }

    before { sign_in rescuer }

    it "approves the request" do
      perform_enqueued_jobs do
        patch approve_adoption_request_path(request_record)
        expect_redirect_to_path(pet_path(pet))
        expect(request_record.reload.status).to eq("approved")
      end
    end
  end

  describe "PATCH /adoption_requests/:id/reject" do
    let!(:request_record) { create(:adoption_request, user: adopter, pet: pet) }

    before { sign_in admin }

    it "rejects the request" do
      perform_enqueued_jobs do
        patch reject_adoption_request_path(request_record)
        expect_redirect_to_path(pet_path(pet))
        expect(request_record.reload.status).to eq("rejected")
      end
    end
  end

  describe "PATCH /adoption_requests/:id/cancel" do
    let!(:request_record) { create(:adoption_request, user: adopter, pet: pet) }

    before { sign_in adopter }

    it "cancels the request" do
      patch cancel_adoption_request_path(request_record)
      expect_redirect_to_path(pet_path(pet))
      expect(request_record.reload.status).to eq("cancelled")
    end
  end

  describe "unauthorized access" do
    let!(:request_record) { create(:adoption_request, user: adopter, pet: pet) }

    it "prevents unauthorized user from approving" do
      sign_in adopter
      patch approve_adoption_request_path(request_record)
      expect_redirect_to_path(root_path)
    end

    it "prevents unauthorized user from cancelling other's request" do
      sign_in rescuer
      patch cancel_adoption_request_path(request_record)
      expect_redirect_to_path(root_path)
    end
  end
end
