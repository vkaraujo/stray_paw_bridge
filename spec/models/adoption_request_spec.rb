# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdoptionRequest, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:pet) }
  end

  describe "enums" do
    it do
      should define_enum_for(:status).with_values(
        pending: 0,
        approved: 1,
        rejected: 2,
        cancelled: 3
      )
    end
  end

  describe "validations" do
    let(:user) { create(:user) }
    let(:pet) { create(:pet) }

    it "allows only one pending request per user and pet" do
      create(:adoption_request, user:, pet:, status: :pending)
      duplicate = build(:adoption_request, user:, pet:, status: :pending)

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:base]).to include("You already have a pending adoption request for this pet.")
    end

    it "allows multiple requests if only one is pending" do
      create(:adoption_request, user:, pet:, status: :approved)
      second = build(:adoption_request, user:, pet:, status: :pending)

      expect(second).to be_valid
    end

    it "skips validation if status is not pending" do
      create(:adoption_request, user:, pet:, status: :pending)
      other = build(:adoption_request, user:, pet:, status: :approved)

      expect(other).to be_valid
    end
  end
end
