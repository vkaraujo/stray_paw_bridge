class AddAdoptionRequestToNotifications < ActiveRecord::Migration[7.1]
  def change
    add_reference :notifications, :adoption_request, foreign_key: true, null: true
  end
end
