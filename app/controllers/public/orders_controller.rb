class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    @order.shipping_cost = 800
    # binding.pry
    if params[:order][:select_address] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name

    elsif params[:order][:select_address] == "2"
      @address = Address.find(params[:order][:select_address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    else

    end
    @total = 0
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.amount = cart_item.amount
      @order_detail.price = cart_item.item.with_tax_price
      @order_detail.save
    end
    current_customer.cart_items.destroy_all
    redirect_to complete_orders_path
  end

  def index
    @orders = current_customer.orders

  end

  def show
  end

  private

  def order_params
     params.require(:order).permit(:payment_method, :postal_code, :address, :name, :shipping_cost, :total_payment)
  end

end
