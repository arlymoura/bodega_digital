module Admin
  class ProductsController < Admin::ApplicationController
    before_action :set_product, only: %i[show edit update destroy]

    def initialize
      super
      # Include the main layout bootstrap file
      require_relative "../../views/#{Rails.configuration.settings.KT_THEME_LAYOUT_DIR}/_bootstrap/default"

      # Initialize the main layout bootstrap class
      KTBootstrapDefault.new.init(helpers)
    end

    # GET /admin/products or /admin/products.json
    def index
      @products = Product.includes(product_variants: :stock_items).paginate(page: params[:page], per_page: 11)
    end

    # GET /admin/products/1 or /admin/products/1.json
    def show; end

    # GET /admin/products/new
    def new
      @product = Product.new(kind: :shoes, status: :active)
      product_variant = @product.product_variants.build
      product_variant.stock_items.build(stock: Stock.first)
    end

    # GET /admin/products/1/edit
    def edit; end

    # POST /admin/products or /admin/products.json
    def create

      @product = Product.new(product_params)
      binding.pry

      respond_to do |format|
        if @product.save
          format.html { redirect_to admin_product_url(@product), notice: "Product was successfully created." }
          format.json { render :show, status: :created, location: @product }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /admin/products/1 or /admin/products/1.json
    def update
      respond_to do |format|
        if @product.update(product_params)
          format.html { redirect_to admin_product_url(@product), notice: "Product was successfully updated." }
          format.json { render :show, status: :ok, location: @product }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /admin/products/1 or /admin/products/1.json
    def destroy
      @product.destroy

      respond_to do |format|
        format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(
        :name, :description, :thumbnail, :category_id, :kind, :status,
        product_variants_attributes: [
          :id, :product_id, :sku, :barcode, :ean,
          { properties: [:type, :value] },
          :_destroy,
          { stock_items_attributes: [
            :id, :product_variant_id, :stock_id, :quantity, :min_quantity, :price, :_destroy
          ] }
        ]
      )
    end
  end
end
