class PackagesController < ApplicationController
before_action :authenticate_user!

  def index
    if params[:search]
      Package.reindex
      @packages = Package.search(params[:search])
    else
      @packages = Package.all.order(created_at: :desc)
    end
  end

  def show
    @package = Package.find_by(id: params[:id])
  end

  def new
    @package = Package.new
  end

  def create
    @package = current_user.packages.new(package_params)

    if @package.save
      redirect_to packages_path
    else
      redirect_to new_package_path
    end
  end

  def edit
    @package = Package.find_by(id: params[:id])
  end

  def update
    @package = Package.find_by(id: params[:id])

    if @package.update(package_params)
      redirect_to package_path(@package)
    else
      redirect_to edit_package_path(@package)
    end
  end

  def destroy
    @package = Package.find_by(id: params[:id])
    if @package.destroy
      redirect_to packages_path
    else
      redirect_to package_path(@package)
    end
  end

  private

  def package_params
    params.require(:package).permit(:title, :description, :price, :location, :service_id)
  end
end
