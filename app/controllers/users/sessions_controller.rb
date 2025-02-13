# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super do |user|
      # Verifica se o usuário pertence a mais de uma empresa
      if user.multiple_companies?
        redirect_to select_company_path and return
      else
        # Define a única empresa como a current_company e o tenant
        company = user.companies.first
        user.update!(current_company: company)
        ActsAsTenant.current_tenant = company # Define o tenant como a empresa
        session[:company_id] = company.id
      end
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
