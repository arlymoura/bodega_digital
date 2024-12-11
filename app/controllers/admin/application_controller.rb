class Admin::ApplicationController < ::ApplicationController
  before_action :authenticate_member!
  # before_action :set_current_store

  def set_current_store
    @current_store = current_member.stores.first if current_member&.owner?
  end
end
