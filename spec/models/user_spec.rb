# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:adoption_requests).dependent(:destroy) }
    it { should have_many(:pets).dependent(:destroy) }
    it { should have_many(:notifications).dependent(:destroy) }
  end

  describe "enums" do
    it { should define_enum_for(:role).with_values(user: 0, admin: 1, institutional: 2) }
  end

  describe "scopes" do
    let!(:active_user) { create(:user, active: true) }
    let!(:inactive_user) { create(:user, active: false) }

    it "returns only active users" do
      expect(User.active).to include(active_user)
      expect(User.active).not_to include(inactive_user)
    end
  end

  describe "#active_for_authentication?" do
    it "returns true if active" do
      user = build(:user, active: true)
      expect(user.active_for_authentication?).to eq(true)
    end

    it "returns false if inactive" do
      user = build(:user, active: false)
      expect(user.active_for_authentication?).to eq(false)
    end
  end

  describe "#inactive_message" do
    it "returns :inactive if user is not active" do
      user = build(:user, active: false)
      expect(user.inactive_message).to eq(:inactive)
    end
  end
end
