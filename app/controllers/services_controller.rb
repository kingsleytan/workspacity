class ServicesController < ApplicationController

  def index
    @services = Service.all
  end

  def show
    @service = Service.find_by(id: params[:id])
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)

    if @service.save
      redirect_to services_path
    else
      redirect_to new_service_path
    end
  end

  def edit
    @service = Service.find_by(id: params[:id])
  end

  def update
    @service = Service.find_by(id: params[:id])

    if @service.update(service_params)
      redirect_to service_path(@service)
    else
      redirect_to edit_service_path(@service)
    end
  end

  def destroy
    @service = Service.find_by(id: params[:id])
    if @service.destroy
      redirect_to services_path
    else
      redirect_to service_path(@service)
    end
  end

  private

  def service_params
    params.require(:service).permit(:type)
  end
end
