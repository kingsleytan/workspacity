class ReviewsController < ApplicationController
  respond_to :js
  before_action :authenticate!, only: [:index, :create, :edit, :update, :new, :destroy]

  def index

    @service = Service.friendly.find(params[:service_id])
    @review = @service.reviews.order(created_at: :desc).page params[:page]
    @review = Review.new
    authorize @review
  end

  def new
    @service = Service.friendly.find(params[:service_id])
    @review = Review.new
    authorize @review
  end

  def create
    @service = Service.friendly.find(params[:service_id])
    @review = current_user.reviews.build(review_params.merge(service_id: @service.id))
    @new_review = Review.new

    if @review.save
      ReviewBroadcastJob.perform_later("create", @review)
      flash.now[:success] = "Your review was posted."
    else
      flash.now[:danger] = @review.errors.full_messages
    end
  end

  def edit
    @service = Service.friendly.find(params[:service_id]
    @review = Review.find_by(id: params[:id])
    authorize @review
  end

  def update
    @service = Service.friendly.find(params[:service_id]
    @review = Review.find_by(id: params[:id])
    authorize @review

    if @review.update(review_params)
      ReviewBroadcastJob.perform_later("update", @review)
      flash.now[:success] = "Your review was updated."
    else
      flash.now[:danger] = @review.errors.full_messages
    end

  end

  def destroy

    @service = Service.friendly.find(params[:service_id]
    @review = Review.find_by(id: params[:id])
    authorize @review

    if @review.destroy
      ReviewBroadcastJob.perform_now("destroy", @review)
      flash.now[:success] = "Your review was deleted."
    end

  end

  private

  def review_params
    params.require(:review).permit(:body, :image)
  end


end
