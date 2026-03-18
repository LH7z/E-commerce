class StockController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only

  def index
    @products = Product.all
  end

  def update
    variant = Variant.find(params[:id])

    if variant.update(stock: params[:stock])
      render json: { success: true }
    else
      render json: { success: false }, status: 422
    end
  end

  private

  def stock_params
    params.require(:product).permit(:stock)
  end

  def admin_only
    redirect_to root_path unless current_user.admin?
  end
end
