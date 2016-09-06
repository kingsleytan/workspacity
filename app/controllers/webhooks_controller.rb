class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def payment_callback
    @order = Order.find_by(bill_id: params[:id}])
    response = Billplz.check_status(@order.id)
    if (response['paid'] == true) && (response['state'] == 'paid')
      @order.update_attributes(state: 'paid', paid_at: params[:paid_at])
    end
    render body: nil
  end

end
