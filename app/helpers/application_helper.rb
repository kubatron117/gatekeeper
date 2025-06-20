module ApplicationHelper
  def nav_link_to(name, path, active: false, block: false)
    classes = []
    classes << (active ? "bg-gray-900 text-white" : "text-gray-300 hover:bg-gray-700 hover:text-white")
    classes << (block ? "block" : "rounded-md")
    classes << "px-3 py-2 text-sm font-medium"
    link_to name, path, class: classes.join(" "), "aria-current": (active ? "page" : nil)
  end
end
