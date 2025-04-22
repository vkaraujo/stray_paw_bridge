# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:adoption_requests).dependent(:destroy) }
    it { should have_one_attached(:photo) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:species) }
    it { should validate_presence_of(:size) }
    it { should validate_presence_of(:status) }
  end

  describe "enums" do
    it { should define_enum_for(:status).with_values(available: 0, pending: 1, adopted: 2) }
    it { should define_enum_for(:species).with_values(dog: 0, cat: 1) }
  end

  describe "geocoding" do
    it "geocodes the address after validation if it changed" do
      pet = build(:pet, address: "Some new address")
      expect(pet).to receive(:geocode)
      pet.valid?
    end
  end
end
