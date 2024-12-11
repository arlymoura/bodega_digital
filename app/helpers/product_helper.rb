module ProductHelper
  def product_kind_badge(kind)
    badge_class = case kind.to_sym
                  when :shoes
                    "badge-light-primary"
                  when :food
                    "badge-light-success"
                  when :drink
                    "badge-light-info"
                  when :clothes
                    "badge-light-warning"
                  when :electronics
                    "badge-light-danger"
                  else
                    "badge-light-secondary"
                  end

    content_tag(:span, kind.to_s.humanize, class: "badge #{badge_class}")
  end

  def product_kind_translations(kind)
    I18n.t("activerecord.enums.product.kind.#{kind}")
  end
end
