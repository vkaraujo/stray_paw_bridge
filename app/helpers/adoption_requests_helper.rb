module AdoptionRequestsHelper
  def status_badge_classes(status)
    {
      approved: "bg-green-100 text-green-800",
      rejected: "bg-red-100 text-red-800",
      cancelled: "bg-gray-200 text-gray-700",
      pending: "bg-yellow-100 text-yellow-800"
    }[status.to_sym] || "bg-gray-100 text-gray-600"
  end

  def chat_and_cancel_buttons(request)
    safe_join([
      link_to(t("dashboard.my_adoptions.chat"),
              adoption_request_messages_path(request),
              class: "inline-block px-3 py-1 text-sm bg-indigo-600 text-white rounded hover:bg-indigo-700"),
      button_to(t("dashboard.my_adoptions.cancel"),
                cancel_adoption_request_path(request),
                method: :patch,
                class: "inline-block px-3 py-1 text-sm bg-red-100 text-red-700 rounded hover:bg-red-200")
    ], " ")
  end
end
