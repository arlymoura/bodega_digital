class Admin::ApplicationController < ::ApplicationController
  helper_method :current_company
  # before_action :authenticate_user!
  set_current_tenant_through_filter
  before_action :set_current_company

  def set_current_company
    if user_signed_in?
      if current_user.current_company
        # Define o tenant atual como a empresa selecionada
        ActsAsTenant.current_tenant = current_user.current_company
      else
        redirect_to select_company_path, alert: "Por favor, selecione uma empresa para continuar."
      end
    end
  end

  def current_company
    @current_company ||= current_user.current_company
  end
end
