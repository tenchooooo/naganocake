class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
    @total = 0
  end

  def update
    order = Order.find(params[:id]) #注文詳細の特定
    order.update(order_params) #注文ステータスの更新
    # byebug
    if order.status == "confirm" #もしステータスが入金確認だったら
      order.order_details.update_all(making_status: 1)#order_ditailのmaking_statusすべて1にこうしん。
    end

    redirect_to admin_order_path(order.id)
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end

end
