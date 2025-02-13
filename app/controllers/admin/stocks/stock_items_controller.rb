module Admin
  module Stocks
    class StockItemsController < Admin::ApplicationController
      before_action :set_dependences, only: %i[edit update]

      def initialize
        super
        # Include the main layout bootstrap file
        require_relative "../../../views/#{Rails.configuration.settings.KT_THEME_LAYOUT_DIR}/_bootstrap/default"

        # Initialize the main layout bootstrap class
        KTBootstrapDefault.new.init(helpers)
      end

      def edit; end

      def update
        respond_to do |format|
          if @product.update(product_params)
            format.html { redirect_to admin_stock_url(@stock, @stock_item), notice: "Stock was successfully updated." }
          else
            format.html { render :edit, status: :unprocessable_entity }
          end
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_dependences
        @stock = Stock.find(params[:id])
        @stock_item = @stock.stock_items.where(id: params[:stock_id]).first
        @product = @stock_item.product
      end

      # Only allow a list of trusted parameters through.
      def product_params
        params.require(:product).permit(
          :name, :description, :thumbnail, :category_id, :kind, :status,
          variants_attributes: [
            :id, :product_id, :sku, :barcode, :ean,
            { properties: [:type, :value] },
            :_destroy,
            { stock_items_attributes: [
              :id, :variant_id, :stock_id, :quantity, :min_quantity, :price, :_destroy
            ] }
          ]
        )
      end
    end
  end
end
