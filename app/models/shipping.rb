class Shipping < ApplicationRecord

  serialize :notification_params, Hash
  def billplz_url(return_path)
    values = {
      business: "merchant@gotealeaf.com",
      cmd: "_xclick",
      upload: 1,
      return: "#{Rails.application.secrets.app_host}#{return_path}",
      invoice: id,
      amount: package.price,
      item_name: package.title,
      item_number: package.id,
      quantity: '1'
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end

end
