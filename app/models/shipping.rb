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
  
  end

end
