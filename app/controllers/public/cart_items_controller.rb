class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items #Customer.allだと客すべてのカートアイテム表示になる。
    @total = 0 #0で数字を入れると宣言する
  end

  def create
    #binding.pry
    @new_cart_item = CartItem.new(cart_item_params)
    if CartItem.find_by(item_id: params[:cart_item][:item_id]) #find_byでcart_item_paramsのitem_idを探し出す。
      @cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id]) #item_idが一致していた場合、@cart_itemに代入
      @cart_item.amount += @new_cart_item.amount.to_i #既存の数字に足す。文字列になっている可能性があるのでto_iでintegerとする。
      @cart_item.update(amount: @cart_item.amount) #アップデートする。amountだけなので、（カラム名：インスタンス名.数とする。）
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

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end
  
  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
  end
  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  end

end
