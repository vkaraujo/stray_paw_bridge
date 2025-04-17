# frozen_string_literal: true

class Admin::PetsController < Admin::BaseController
  def index
    @pets = Pet.includes(:user).order(created_at: :desc)
  end

  def toggle_visibility
    @pet = Pet.find(params[:id])
    @pet.update(visible: !@pet.visible)
    redirect_to admin_pets_path, notice: "#{@pet.name} is now #{ @pet.visible? ? 'visible' : 'hidden' }."
  end
end
