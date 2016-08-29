class ServicesController < ApplicationController

  def index
    @services = Service.all
  end

  def show
    @service = Service.find_by(id: params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
