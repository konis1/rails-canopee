module ApplicationHelper

  def page_background_color_class
    if current_page?(gardens_path)
      "bg-green"
    elsif current_page?(root_path)
      "bg-red"
    end
  end

  def color_level(percentage)
    if percentage < 25
      return "#ef476f"
    elsif percentage < 50
      return "#ffd166"
    elsif percentage < 75
      return "#fb5607"
    elsif percentage <=100
      return "#06d6a0"
    end
  end
end
