module ApplicationHelper

  def page_background_color_class
    if current_page?(gardens_path)
      "bg-green"
    elsif current_page?(root_path)
      "bg-red"
    end
  end

  def color_level(percentage)
    coef         = percentage.fdiv(100)
    red, green = "F91818", "57A262"

    vr, vg, vb = red.scan(/.{2}/).map { |e| e.to_i(16) }
    pr, pg, pb = green.scan(/.{2}/).map { |e| e.to_i(16) }

    r = (vr + ((pr - vr) * coef).round).to_s(16)
    g = (vg + ((pg - vg) * coef).round).to_s(16)
    b = (vb + ((pb - vb) * coef).round).to_s(16)

    "##{r}#{g}#{b}"
  end
end
