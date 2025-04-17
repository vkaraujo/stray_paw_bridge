# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  # Optional: handle authorization errors gracefully
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :set_locale

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referer || root_path)
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
