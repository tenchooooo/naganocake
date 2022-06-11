class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all

  end

  def create
    #binding.pry
    @new_cart_item = CartItem.new(cart_item_params)
    if CartItem.find_by(item_id: params[:cart_item][:item_id])
      @cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
      @cart_item.amount += @new_cart_item.amount.to_i
      @cart_item.update(amount: @cart_item.amount)
      redirect_to cart_items_path
    else
      if @new_cart_item.save
        redirect_to cart_items_path
      else

      end
    end
  end
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  end

end
