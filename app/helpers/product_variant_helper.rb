module ProductVariantHelper
  def variant_status_badge(status)
    badge_class = case status.to_sym
                  when :active
                    "badge-light-success"
                  when :disabled
                    "badge-light-danger"
                  when :scheduled
                    "badge-light-primary"
                  else
                    "badge-light-secondary"
                  end

    content_tag(:span, variant_status_translations(status), class: "badge #{badge_class}")
  end

  def variant_status_translations(status)
    I18n.t("activerecord.enums.variant.status.#{status}")
  end
end
