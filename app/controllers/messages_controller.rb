# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_adoption_request
  before_action :authorize_chat!

  def index
    @messages = @adoption_request.messages.includes(:user).order(:created_at)
    @message = Message.new
  end

  def create
    @message = @adoption_request.messages.build(message_params.merge(user: current_user))

    if @message.save
      redirect_to adoption_request_messages_path(@adoption_request)
    else
      @messages = @adoption_request.messages.includes(:user).order(:created_at)
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_adoption_request
    @adoption_request = AdoptionRequest.find(params[:adoption_request_id])
  end

  def authorize_chat!
    unless @adoption_request.user == current_user || @adoption_request.pet.user == current_user
      redirect_to root_path, alert: "You're not allowed to access this chat."
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
