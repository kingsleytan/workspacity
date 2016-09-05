class CartsController < ApplicationController
  before_action :load_cart, except: [:clear_cart]
  after_action :write_cart, only: [:add_package, :remove_package, :update_package, :clear_cart]

  def load_cart
    if cookies[:cart]
      @cart = JSON.parse(cookies[:cart])
    else
      @cart = {}
    end
  end

  def write_cart
    cookies[:cart] = JSON.generate(@cart)
  end

  def show
    @packages = []
    @order = Order.new
    @cart.each do |package_id,quantity|
      package = Package.find_by(id: package_id)
      package.define_singleton_method(:quantity) do
        quantity
      end
      @packages << package
    end
  end

  def add_package
    if @cart[params[:id]]
      quantity = params[:quantity].to_i
      quantityOld = @cart[params[:id]].to_i
      @cart[params[:id]] = quantityOld + quantity
    else
      @cart[params[:id]] = params[:quantity]
    end
  end

  def update_package
    if @cart[params[:id]]
      @cart[params[:id]] = params[:quantity]
    end
    redirect_to cart_path
  end

  def remove_package
    @cart.delete params[:id]
    redirect_to cart_path
  end

  def clear_cart
    @cart = {}

  end

end
