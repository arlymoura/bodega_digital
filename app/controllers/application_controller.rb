class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
        # TODO: 'retornar aqui para usuarios com multiplas empresas, ajustar para retornar para a empresa correta'
        # @current_company = resource.memberships.first.company 
        resource.current_company = resource.memberships.first.company
        admin_root_path
      
    elsif resource.is_a?(Customer)
      root_path
    else
      super
    end
  end

  # Main initialization
  def initialize
    initThemeMode
    initThemeDirection
    initLayout
  end

  # Init theme mode option from settings
  def initThemeMode
    helpers.setModeSwitch(Rails.configuration.settings.KT_THEME_MODE_SWITCH_ENABLED)
    helpers.setModeDefault(Rails.configuration.settings.KT_THEME_MODE_DEFAULT)
  end

  # Init theme direction option (RTL or LTR) from settings
  # Init RTL html attributes by checking if RTL is enabled.
  # This function is being called for the html tag
  def initThemeDirection
    helpers.setDirection(Rails.configuration.settings.KT_THEME_DIRECTION)

    return unless helpers.isRtlDirection

    helpers.addHtmlAttribute('html', 'direction', 'rtl')
    helpers.addHtmlAttribute('html', 'dir', 'rtl')
    helpers.addHtmlAttribute('html', 'style', 'direction: rtl')
  end

  # Init layout html attributes and classes
  def initLayout
    helpers.addHtmlAttribute('body', 'id', 'kt_app_body')
    helpers.addHtmlAttribute('body', 'data-kt-name', helpers.getName)
  end
end
