module StockHelper
  def stock_status_badge(status)
    badge_class = case status.to_sym
                  when :active
                    "badge-success"
                  when :disabled
                    "badge-danger"
                  else
                    "badge-secondary"
                  end

    content_tag(:span, stock_status_translations(status), class: "badge #{badge_class}")
  end

  def stock_status_translations(status)
    I18n.t("activerecord.enums.stock.status.#{status}")
  end
end
