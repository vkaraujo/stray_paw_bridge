# frozen_string_literal: true

class AdoptionRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request, only: [:approve, :reject, :cancel]

  def create
    @request = current_user.adoption_requests.build(adoption_request_params)

    if @request.save
      Notification.create!(
        user: @request.pet.user,
        message: "#{current_user.email} has submitted an adoption request for #{@request.pet.name}."
      )

      redirect_to pet_path(@request.pet), notice: "Adoption request sent!"
    else
      logger.debug "FAILED REQUEST: #{@request.errors.full_messages.inspect}"
      redirect_to pet_path(@request.pet), alert: @request.errors.full_messages.to_sentence
    end
  end

  def approve
    unless authorize_owner!
      redirect_to root_path, alert: "Not authorized." and return
    end
  
    if @request.update(status: :approved)
      Notification.create!(user: @request.user, message: "Your adoption request for #{@request.pet.name} was approved.")
      NotificationMailer.adoption_approved(@request.user, @request.pet).deliver_later
      redirect_to pet_path(@request.pet), notice: "Request approved."
    else
      redirect_to pet_path(@request.pet), alert: "Could not approve request."
    end
  end

  def reject
    authorize_owner!
    if @request.update(status: :rejected)
      Notification.create!(user: @request.user, message: "Your adoption request for #{@request.pet.name} was rejected.")

      NotificationMailer.adoption_rejected(@request.user, @request.pet).deliver_later

      redirect_to pet_path(@request.pet), notice: "Request rejected."
    else
      redirect_to pet_path(@request.pet), alert: "Could not reject request."
    end
  end

  
  def cancel
    unless authorize_adopter!
      redirect_to root_path, alert: "Not authorized." and return
    end

    if @request.update(status: :cancelled)
      redirect_to pet_path(@request.pet), notice: "Request cancelled."
    else
      redirect_to pet_path(@request.pet), alert: "Could not cancel request."
    end
  end

  private

  def authorize_owner!
    @request.pet.user == current_user || current_user.admin?
  end

  def authorize_adopter!
    @request.user == current_user
  end

  def set_request
    @request = AdoptionRequest.find(params[:id])
  end

  def adoption_request_params
    params.require(:adoption_request).permit(:pet_id, :message)
  end
end
