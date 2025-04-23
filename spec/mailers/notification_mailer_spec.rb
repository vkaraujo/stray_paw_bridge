# frozen_string_literal: true

require "rails_helper"

RSpec.describe NotificationMailer, type: :mailer do
  let(:user) { create(:user, email: "adopter@example.com") }
  let(:pet) { create(:pet, name: "Buddy") }

  describe "#adoption_approved" do
    let(:mail) { described_class.adoption_approved(user, pet) }

    it "sends to the correct user" do
      expect(mail.to).to eq(["adopter@example.com"])
    end

    it "has the correct subject" do
      expect(mail.subject).to eq("Your adoption request for Buddy was approved!")
    end

    it "includes pet name in body" do
      expect(mail.body.encoded).to include("Buddy")
    end
  end

  describe "#adoption_rejected" do
    let(:mail) { described_class.adoption_rejected(user, pet) }

    it "sends to the correct user" do
      expect(mail.to).to eq(["adopter@example.com"])
    end

    it "has the correct subject" do
      expect(mail.subject).to eq("Your adoption request for Buddy was rejected.")
    end

    it "includes pet name in body" do
      expect(mail.body.encoded).to include("Buddy")
    end
  end
end
