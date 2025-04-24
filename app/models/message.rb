class Message < ApplicationRecord
  belongs_to :user
  belongs_to :adoption_request

  validates :content, presence: true
end
