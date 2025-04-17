# frozen_string_literal: true

class Admin::PetsController < Admin::BaseController
  def index
    @pets = Pet.includes(:user).order(created_at: :desc)
  end

  def toggle_status
    @pet = Pet.find(params[:id])
    if @pet.available?
      @pet.adopted!
    else
      @pet.available!
    end

    redirect_to admin_pets_path, notice: "Toggled status for #{@pet.name}."
  end
end
