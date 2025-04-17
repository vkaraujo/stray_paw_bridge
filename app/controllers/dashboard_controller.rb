# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @my_pets = current_user.pets.order(created_at: :desc)
    @my_adoption_requests = current_user.adoption_requests.includes(:pet).order(created_at: :desc)
    @notifications = []
  end
end
