class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  
  def confirm
  end
  
  def complete
  end
  
  def create
    @oeder = Order.new(oeder_params)
    @oeder.save
    redirect_to confirm_orders_path
  end
  
  def index
  end
  
  def show
  end
  
  private
  
end
