class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification

  def mark_as_read
    if @notification.user == current_user
      @notification.update(read: true)
      redirect_to dashboard_path, notice: "Notification marked as read."
    else
      redirect_to dashboard_path, alert: "Not authorized."
    end
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end
end
