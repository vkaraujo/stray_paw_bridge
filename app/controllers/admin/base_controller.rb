# frozen_string_literal: true

class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  private

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "You are not authorized to access admin panel."
    end
  end
end
