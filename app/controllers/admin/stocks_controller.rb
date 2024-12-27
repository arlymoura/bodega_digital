module Admin
  class StocksController < Admin::ApplicationController
    before_action :set_product, only: %i[show edit update destroy]

    def initialize
      super
      # Include the main layout bootstrap file
      require_relative "../../views/#{Rails.configuration.settings.KT_THEME_LAYOUT_DIR}/_bootstrap/default"

      # Initialize the main layout bootstrap class
      KTBootstrapDefault.new.init(helpers)
    end

    def index
      @stocks = Stock.includes(:stock_items).paginate(page: params[:page], per_page: 11)
    end

    # GET /admin/products/1 or /admin/products/1.json
    def show
      @products = @stock.products.includes(product_variants: :stock_items).paginate(page: params[:page], per_page: 11)
    end

    # GET /admin/products/new
    def new
      @stock = Stock.new
    end

    # GET /admin/products/1/edit
    def edit; end

    # POST /admin/products or /admin/products.json
    def create

      @stock = Stock.new(product_params)

      respond_to do |format|
        if @stock.save
          format.html { redirect_to admin_stock_url(@stock), notice: "Stock was successfully created." }
          format.json { render :show, status: :created, location: @stock }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @stock.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /admin/products/1 or /admin/products/1.json
    def update
      respond_to do |format|
        if @stock.update(product_params)
          format.html { redirect_to admin_stock_url(@stock), notice: "Stock was successfully updated." }
          format.json { render :show, status: :ok, location: @stock }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @stock.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /admin/products/1 or /admin/products/1.json
    def destroy
      @stock.destroy

      respond_to do |format|
        format.html { redirect_to stocks_url, notice: "Stock was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @stock = Stock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:stock).permit(:name, :description, :kind, :status)
    end
  end
end
