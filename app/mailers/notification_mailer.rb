# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  def adoption_approved(user, pet)
    @user = user
    @pet = pet
    mail(to: user.email, subject: "Your adoption request for #{@pet.name} was approved!")
  end

  def adoption_rejected(user, pet)
    @user = user
    @pet = pet
    mail(to: user.email, subject: "Your adoption request for #{@pet.name} was rejected.")
  end
end
