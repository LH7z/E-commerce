class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user.admin?
      @orders = Order.all
    else
      @orders = Order.where(user: current_user)
    end
  end
end
