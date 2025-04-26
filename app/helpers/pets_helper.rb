module PetsHelper
  def status_badge(pet)
    color_classes = {
      "available" => "bg-green-100 text-green-800",
      "pending"   => "bg-yellow-100 text-yellow-800",
      "adopted"   => "bg-gray-200 text-gray-700"
    }

    content_tag(:span,
      pet.status.titleize,
      class: "inline-block px-2 py-1 text-xs font-semibold rounded-full #{color_classes[pet.status]}"
    )
  end
end
