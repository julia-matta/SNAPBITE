module ApplicationHelper
  def devise_page?
    controller_name == "sessions" ||
    controller_name == "registrations" ||
    controller_name == "passwords"
  end
end
