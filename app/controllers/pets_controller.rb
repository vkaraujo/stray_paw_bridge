# frozen_string_literal: true

class PetsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_pet, only: [:show, :edit, :update, :destroy]
  before_action :authorize_pet!, only: [:edit, :update, :destroy]

  def index
    @pets = Pet.available.includes(photo_attachment: :blob)
  end

  def show
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

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def authorize_pet!
    redirect_to root_path, alert: "Not authorized." unless @pet.user == current_user || current_user.admin?
  end

  def pet_params
    params.require(:pet).permit(:name, :description, :species, :age, :size, :status, :photo)
  end
end
