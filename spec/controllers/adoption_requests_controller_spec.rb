require 'rails_helper'

RSpec.describe AdoptionRequestsController, type: :controller do
  include Devise::Test::ControllerHelpers
  include ActiveJob::TestHelper

  let(:rescuer) { create(:user) }
  let(:adopter) { create(:user) }
  let(:admin)   { create(:user, role: :admin) }
  let(:pet)     { create(:pet, user: rescuer) }

  describe "POST #create" do
    before { sign_in adopter }

    it "creates a new adoption request" do
      expect {
        post :create, params: { adoption_request: { pet_id: pet.id, message: "Please let me adopt!" } }
      }.to change(AdoptionRequest, :count).by(1)

      expect(response).to redirect_to(pet_path(pet))
    end
  end

  describe "PATCH #approve" do
    let!(:request_record) { create(:adoption_request, user: adopter, pet: pet) }

    before { sign_in rescuer }

    it "approves the request" do
      perform_enqueued_jobs do
        patch :approve, params: { id: request_record.id }
        expect(response).to redirect_to(pet_path(pet))
        expect(AdoptionRequest.find(request_record.id).status).to eq("approved")
      end
    end
  end

  describe "PATCH #reject" do
    let!(:request_record) { create(:adoption_request, user: adopter, pet: pet) }

    before { sign_in admin }

    it "rejects the request" do
      perform_enqueued_jobs do
        patch :reject, params: { id: request_record.id }
        expect(AdoptionRequest.find(request_record.id).status).to eq("rejected")
        expect(response).to redirect_to(pet_path(pet))
      end
    end
  end

  describe "PATCH #cancel" do
    let!(:request_record) { create(:adoption_request, user: adopter, pet: pet) }

    before { sign_in adopter }

    it "cancels the request" do
      patch :cancel, params: { id: request_record.id }
      expect(response).to redirect_to(pet_path(pet))
      expect(AdoptionRequest.find(request_record.id).status).to eq("cancelled")
    end
  end

  describe "unauthorized access" do
    let!(:request_record) { create(:adoption_request, user: adopter, pet: pet) }

    it "prevents unauthorized user from approving" do
      sign_in adopter
      patch :approve, params: { id: request_record.id }
      expect(response).to redirect_to(root_path)
    end

    it "prevents unauthorized user from cancelling other's request" do
      sign_in rescuer
      patch :cancel, params: { id: request_record.id }
      expect(response).to redirect_to(root_path)
    end
  end
end
