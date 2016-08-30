class ReviewsController < ApplicationController

  def index
    @packages = Package.includes(:packages).find(params[:package_id])
    @reviews = Review.all
    if params[:search]
      @reviews = Review.search(params[:search]).order("created_at DESC")
    else
      @reviews = Review.all.order('created_at DESC')
    end
  end

  def new
    @package = Package.find(params[:package_id])
    @review = Review.new
  end

  def create
    @package = Package.find(params[:package_id])
    @review = current_user.reviews.build(review_params.merge(package_id: params[:package_id]))

    if @review.save
      flash[:success] = "You've created a new review."
      redirect_to package_reviews_path(@package)
    else
      flash[:danger] = @review.errors.full_messages
      redirect_to new_package_review_path(@package)
    end
  end

  def edit
    @review = Review.find(params[:id])
    @package = @review.package

  end

  def update

    @review = Review.find(params[:id])
    @package = @review.package

    if @review.update(review_params)
      redirect_to package_reviews_path(@package)
    else
      redirect_to edit_package_review_path(@package, @review)
    end
  end

  def destroy
    @review = review.find_by(id: params[:id])
    @package = @review.package
    if @review.destroy
      redirect_to package_reviews_path(@package)
    end
  end

  private

  def review_params
    params.require(:review).permit(:image, :body)
  end
end
