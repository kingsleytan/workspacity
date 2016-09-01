class PackagesController < ApplicationController
  before_action :authenticate!, only: [:create, :edit, :update, :new, :destroy]

  def index
  end

  def show
  end

  def new
  end

  def create
      @packages = current_user.packages.build(topic_params)
    if @packages.save
      redirect_to packages_path
    else
      redirect_to _path
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
