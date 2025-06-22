module ApplicationHelper
  def nav_link_to(name, path, active: nil, block: false)
    is_active = active.nil? ? current_page?(path) : active

    classes = []
    classes << (is_active ? "bg-gray-900 text-white" : "text-gray-300 hover:bg-gray-700 hover:text-white")
    classes << (block ? "block" : "rounded-md")
    classes << "px-3 py-2 text-sm font-medium"
    link_to name, path, class: classes.join(" "), "aria-current": (is_active ? "page" : nil)
  end

  def new_singular_lower(title)
    "New " + title.to_s.singularize.downcase
  end
end
