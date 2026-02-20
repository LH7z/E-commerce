class HomeController < ApplicationController
  def index
    @discounted_products = Product.where("discount > 0")
    @latest_products = Product.order(created_at: :desc).limit(3)
  end
end
