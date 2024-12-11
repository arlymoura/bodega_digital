# lib/custom_link_renderer.rb
require 'will_paginate/view_helpers/action_view'
require 'action_view/helpers/tag_helper'

class CustomLinkRenderer < WillPaginate::ActionView::LinkRenderer
  include ActionView::Helpers::TagHelper
  include ActionView::Context

  protected

  def html_container(html)
    content_tag(:div, content_tag(:ul, html.html_safe, class: 'pagination'), class: 'dt-paging paging_simple_numbers')
  end

  def page_number(page)
    if page == current_page
      content_tag(:li, class: 'dt-paging-button page-item active') do
        link(page, href: url_for_page(page), class: 'page-link', 'aria-controls' => 'kt_ecommerce_products_table',
                   'aria-current' => 'page', 'data-dt-idx' => page, tabindex: '1').html_safe
      end
    else
      content_tag(:li, class: 'dt-paging-button page-item') do
        link(page, href: url_for_page(page), class: 'page-link', 'aria-controls' => 'kt_ecommerce_products_table',
                   'data-dt-idx' => page, tabindex: '0').html_safe
      end
    end
  end

  def previous_or_next_page(page, text, classname, aria_label)
    if page
      content_tag(:li, class: 'dt-paging-button page-item') do
        link(check_name(text), href: url_for_page(page), class: "page-link #{classname}", 'aria-controls' => 'kt_ecommerce_products_table',
                               'aria-label' => aria_label, 'data-dt-idx' => classname, tabindex: '0').html_safe
      end
    else
      content_tag(:li, class: 'dt-paging-button page-item disabled') do
        link(check_name(text), href: '#', class: "page-link #{classname}", 'aria-controls' => 'kt_ecommerce_products_table',
                               'aria-disabled' => 'true', 'aria-label' => aria_label, 'data-dt-idx' => classname, tabindex: '-1').html_safe
      end
    end
  end

  def gap
    content_tag(:li, class: 'dt-paging-button page-item disabled') do
      link('...', href: '#', class: 'page-link').html_safe
    end
  end

  private

  def link(text = nil, options = {}, &block)
    content_tag(:a, text, options, &block).html_safe
  end

  def url_for_page(page)
    # Gera a URL para a página especificada, mantendo todos os parâmetros de consulta
    Rails.application.routes.url_helpers.url_for(params.merge(page:, only_path: true))
  end

  def params
    @params ||= @template.params.except(:page).permit!
  end

  def check_name(text)
    display_text = case text
                   when /Previous/i
                     '<'
                   when /Next/i
                     '>'
                   else
                     text
                   end
  end
end
