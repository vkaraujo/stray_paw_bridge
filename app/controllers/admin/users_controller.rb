# frozen_string_literal: true

class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
    @users = @users.where(role: params[:role]) if params[:role].present?
    @users = @users.where(active: params[:active]) if params[:active].present?
    @users = @users.order(created_at: :desc)
  end

  def toggle_admin
    user = User.find(params[:id])
    user.update(role: user.admin? ? :user : :admin)
    redirect_to admin_users_path, notice: "Updated #{user.email}'s role."
  end

  def toggle_active
    user = User.find(params[:id])
    user.update(active: !user.active)
    redirect_to admin_users_path, notice: "Toggled active status for #{user.email}."
  end
end
