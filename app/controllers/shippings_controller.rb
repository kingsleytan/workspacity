class ShippingsController < ApplicationController

  def index
    @user = current_user
  end

  def order_confirmation
    @cart = JSON.parse(cookies[:cart])
    @packages = []
    @cart.each do |package_id,quantity|
      package = Package.find_by(id: package_id)
      package.define_singleton_method(:quantity) do
        quantity
      end
      @packages << package
    end
    # cookies[:cart].delete
  end

end
