class NotificationMailerPreview < ActionMailer::Preview
  def adoption_approved
    user = User.first
    pet = Pet.first
    NotificationMailer.adoption_approved(user, pet)
  end

  def adoption_rejected
    user = User.first
    pet = Pet.first
    NotificationMailer.adoption_rejected(user, pet)
  end
end
