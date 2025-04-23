# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Home", type: :request do
  describe "GET /" do
    let!(:with_photos) do
      create_list(:pet, 10, status: :available).each do |pet|
        pet.photo.attach(
          io: File.open(Rails.root.join('spec/fixtures/files/sample.jpg')),
          filename: 'sample.jpg',
          content_type: 'image/jpeg'
        )
      end
    end

    let!(:adopted_with_photos) do
      create_list(:pet, 5, status: :adopted).each do |pet|
        pet.photo.attach(
          io: File.open(Rails.root.join('spec/fixtures/files/sample.jpg')),
          filename: 'sample.jpg',
          content_type: 'image/jpeg'
        )
      end
    end

    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:ok)
    end

    it "includes names of available pets with photos" do
      get root_path
      with_photos.each do |pet|
        expect(response.body).to include(pet.name)
      end
    end

    it "limits the number of pets to 12" do
      get root_path
      count = Nokogiri::HTML(response.body).css("h3").select { |node| node.text.strip.present? }.count
      expect(count).to be <= 12
    end
  end
end
