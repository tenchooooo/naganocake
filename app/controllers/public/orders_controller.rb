class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
  end

  def complete
  end

  def create
    @oeder = Order.new(order_params)
    @oeder.save
    redirect_to confirm_orders_path
  end

  def index
  end

  def show
  end

  private

  def order_params
     params.require(:order).permit(:postal_code, :address, :name, :shpping_cost, :total_payment, :payment_method, :status, :customer_id)
  end

end
