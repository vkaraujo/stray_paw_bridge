class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { user: 0, admin: 1, institutional: 2 }

  has_many :adoption_requests, dependent: :destroy
  has_many :pets, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :messages

  scope :active, -> { where(active: true) }

  def active_for_authentication?
    super && active?
  end

  def inactive_message
    active? ? super : :inactive
  end

  def name
    email.split('@').first
  end
end
