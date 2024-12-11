module StockItemHelper
  def stock_item_status_badge(stock_item)
    return stock_item.quantity.to_s unless stock_item.low_stock?

    content_tag(:span, "baixo", class: "badge badge-light-warning") +
      content_tag(:span, stock_item.quantity.to_s, class: "fw-bold text-warning ms-3")
  end
end
