class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
    @order = order_detail.order
    if order_detail.making_status == "make" #もし、order_ditailのmaking_statusがmakeだったら
      order_detail.order.update(status: 2) #orderのsutatusを2に更新する。
    elsif @order.order_details.count == @order.order_details.where(making_status: 3).count
      order_detail.order.update(status: 3)
    end
    redirect_to admin_order_path(order_detail.order.id)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
