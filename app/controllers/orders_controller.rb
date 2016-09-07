class OrdersController < ApplicationController
before_action :authenticate_user!

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.new(order_params)
    # @order = Order.create(total: params[:totalprice], user_id: params[:user_id])
    if @order.save
      @bill = Billplz.create_bill_for(@order)
      @order.update_attributes(bill_id: @bill.parsed_response['id'], bill_url: @bill.parsed_response['url'])
      cookies.delete :cart
      redirect_to @bill.parsed_response['url']
    else
      render :new
    end

  end

  private
  def order_params
    params.require(:order).permit(:user_id, :status, :total, :bill_id, :bill_url, :due_at, :paid_at)
  end

end
