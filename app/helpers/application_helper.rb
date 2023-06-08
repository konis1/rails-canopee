module ApplicationHelper
  def page_background_color_class
    if current_page?(gardens_path)
      "bg-green"
    elsif current_page?(root_path)
      "bg-red"
    end
  end
end
