# frozen_string_literal: true

class PetsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_pet, only: [:show, :edit, :update, :destroy, :conclude_adoption]
  before_action :authorize_pet!, only: [:edit, :update, :destroy]

  def index
    @pets = Pet.available

    @pets = @pets.where(species: params[:species]) if params[:species].present?
    @pets = @pets.where(size: params[:size]) if params[:size].present?

    if params[:location].present?
      radius = params[:radius].presence || 20
      @pets = @pets.near(params[:location], radius, units: :km)
    end
  end

  def show
    @adoption_request = latest_relevant_request
    @incoming_requests = @pet.adoption_requests.includes(:user) if current_user == @pet.user || current_user&.admin?
  end

  def new
    @pet = current_user.pets.build
  end

  def create
    @pet = current_user.pets.build(pet_params)
    if @pet.save
      redirect_to @pet, notice: "Pet listed successfully!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @pet.update(pet_params)
      redirect_to @pet, notice: "Pet updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    @pet.destroy
    redirect_to pets_path, notice: "Pet removed."
  end

  def conclude_adoption
    if @pet.user == current_user && @pet.status != "adopted"
      @pet.update(status: :adopted)
      redirect_to dashboard_path, notice: "Adoption concluded!"
    else
      redirect_to pet_path(@pet), alert: "You can't conclude this adoption."
    end
  end

  private

  def latest_relevant_request
    return nil unless current_user

    requests = current_user.adoption_requests.where(pet: @pet).order(created_at: :desc)

    requests.find(&:pending?) || requests.first
  end

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def authorize_pet!
    redirect_to root_path, alert: "Not authorized." unless @pet.user == current_user || current_user.admin?
  end

  def pet_params
    params.require(:pet).permit(:name, :description, :species, :age, :size, :status, :photo, :address)
  end
end
