# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Pets", type: :request do
  let(:user) { create(:user) }
  let(:admin) { create(:user, role: :admin) }
  let(:other_user) { create(:user) }

  describe "GET /pets" do
    before do
      create_list(:pet, 2, status: :available, species: :dog, size: "Small")
      create(:pet, status: :adopted, species: :cat)
    end

    it "renders index and only shows available pets" do
      dog1 = create(:pet, status: :available, name: "Rex")
      dog2 = create(:pet, status: :available, name: "Bolt")
      cat = create(:pet, status: :adopted, name: "Whiskers")

      get pets_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Rex", "Bolt")
      expect(response.body).not_to include("Whiskers")
    end

    it "filters by species and size" do
      get pets_path, params: { species: "dog", size: "Small" }
      expect(response.body).to include("dog")
    end
  end

  describe "GET /pets/:id" do
    let(:pet) { create(:pet, user: user) }

    it "shows the pet" do
      get pet_path(pet)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(pet.name)
    end
  end

  describe "GET /pets/new" do
    it "requires login" do
      get new_pet_path
      expect(response).to redirect_to(new_user_session_path)
    end

    it "renders form for logged-in users" do
      sign_in user
      get new_pet_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /pets" do
    let(:valid_params) do
      {
        pet: {
          name: "Buddy",
          description: "Sweet dog",
          species: "dog",
          age: 2,
          size: "Medium",
          status: "available",
          address: "São Paulo, Brazil"
        }
      }
    end

    it "requires authentication" do
      post pets_path, params: valid_params
      expect(response).to redirect_to(new_user_session_path)
    end

    it "creates a pet when logged in" do
      sign_in user
      expect {
        post pets_path, params: valid_params
      }.to change(Pet, :count).by(1)

      expect(URI.parse(response.location).path).to eq(pet_path(Pet.last))
    end

    it "renders new on validation error" do
      sign_in user
      post pets_path, params: {
        pet: {
          description: "Sweet dog",
          species: "dog",
          age: 2,
          size: "Medium",
          status: "available",
          address: "São Paulo"
        }
      }
    
      expect(response.body).to include("não pode ficar em branco") # or check for label
    end
  end

  describe "GET /pets/:id/edit" do
    let(:pet) { create(:pet, user: user) }

    it "redirects non-authenticated users" do
      get edit_pet_path(pet)
      expect(response).to redirect_to(new_user_session_path)
    end

    it "blocks other users" do
      sign_in other_user
      get edit_pet_path(pet)
      expect(URI.parse(response.location).path).to eq(root_path)
    end

    it "allows owner to edit" do
      sign_in user
      get edit_pet_path(pet)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /pets/:id" do
    let(:pet) { create(:pet, user: user, name: "Old Name") }

    it "updates pet for the owner" do
      sign_in user
      patch pet_path(pet), params: { pet: { name: "New Name" } }
      expect(pet.reload.name).to eq("New Name")
    end

    it "blocks update from others" do
      sign_in other_user
      patch pet_path(pet), params: { pet: { name: "Hacked" } }
      expect(pet.reload.name).to eq("Old Name")
    end
  end

  describe "DELETE /pets/:id" do
    let!(:pet) { create(:pet, user: user) }

    it "allows owner to delete" do
      sign_in user
      expect {
        delete pet_path(pet)
      }.to change(Pet, :count).by(-1)
      expect(URI.parse(response.location).path).to eq(pets_path)
    end

    it "blocks deletion by non-owners" do
      sign_in other_user
      delete pet_path(pet)
      expect(URI.parse(response.location).path).to eq(root_path)
    end
  end
end
