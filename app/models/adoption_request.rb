class AdoptionRequest < ApplicationRecord
  belongs_to :user
  belongs_to :pet

  enum status: { pending: 0, approved: 1, rejected: 2, cancelled: 3 }

  validate :no_duplicate_pending_requests

  private

  def no_duplicate_pending_requests
    return unless status == "pending"

    if AdoptionRequest.where.not(id: id).exists?(
         user_id: user_id,
         pet_id: pet_id,
         status: :pending
       )
      errors.add(:base, "You already have a pending adoption request for this pet.")
    end
  end
end
