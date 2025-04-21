# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @pets = Pet.available
               .with_attached_photo
               .joins(:photo_attachment)
               .order(Arel.sql('RANDOM()'))
               .limit(12)
  end
end
