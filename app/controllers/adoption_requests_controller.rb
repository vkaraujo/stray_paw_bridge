# frozen_string_literal: true

class AdoptionRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request, only: [:approve, :reject, :cancel]

  def create
    @request = current_user.adoption_requests.build(adoption_request_params)

    if @request.save
      redirect_to pet_path(@request.pet), notice: "Adoption request sent!"
    else
      redirect_to pet_path(@request.pet), alert: @request.errors.full_messages.to_sentence
    end
  end

  def approve
    authorize_owner!
    if @request.update(status: :approved)
      redirect_to pet_path(@request.pet), notice: "Request approved."
    else
      redirect_to pet_path(@request.pet), alert: "Could not approve request."
    end
  end

  def reject
    authorize_owner!
    if @request.update(status: :rejected)
      redirect_to pet_path(@request.pet), notice: "Request rejected."
    else
      redirect_to pet_path(@request.pet), alert: "Could not reject request."
    end
  end

  def cancel
    authorize_adopter!
    if @request.update(status: :cancelled)
      redirect_to pet_path(@request.pet), notice: "Request cancelled."
    else
      redirect_to pet_path(@request.pet), alert: "Could not cancel request."
    end
  end

  private

  def authorize_owner!
    redirect_to root_path, alert: "Not authorized." unless @request.pet.user == current_user || current_user.admin?
  end

  def authorize_adopter!
    redirect_to root_path, alert: "Not authorized." unless @request.user == current_user
  end

  def set_request
    @request = AdoptionRequest.find(params[:id])
  end

  def adoption_request_params
    params.require(:adoption_request).permit(:pet_id, :message)
  end
end
