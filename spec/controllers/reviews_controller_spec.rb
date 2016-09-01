require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do

  before(:all) do

    @admin = create(:user, :admin)
    @moderator = create(:user, :moderator)
    @user = create(:user)
    @invader_zim = create(:user, :sequenced_email, :sequenced_username)
    @service = create(:service)

    4.times { create(:review, :sequenced_body, user_id: @user.id }
  end

  describe "index reviews" do
    it "should deny if user not logged in" do

      params = { service_id: @service.id }
      get :index, params: params

      expect(flash[:danger]).to eql("You need to login first")

    end

    it "should render index" do

      session[:id] = @user.id
      params = { service_id: @service.id}
      get :index, params: params

      expect(subject).to(render_template(:index))

    end
  end

  describe "create review" do
    it "should deny if user not logged in" do

      params = { service_id: @service.id, service: { body: "New Body", image: "newimage"  } }
      post :create, xhr: true, params: params

      expect(flash[:danger]).to eql("You need to login first")
    end

    it "should create new comment" do

      session[:id] = @invader_zim.id
      params = { service_id: @service.id, review: { body: "New Body", image: "newimage"  } }
      post :create, xhr: true, params: params

      review = @invader_zim.reviews.first

      expect(@service.reviews.count).to eql(5)
      expect(review.body).to eql("New Body")
      expect(review.post).to eql(@service)
    end
  end

  describe "update comment" do
    it "should deny if user not logged in" do

      @review = Review.first
      params = { service_id: @service.id, @review.id, review: { body: "Update body" } }
      patch :update, xhr: true, params: params

      expect(flash[:danger]).to eql("You need to login first")
    end

    it "should deny unauthorized user" do

      session[:id] = @invader_zim.id
      @review = Review.first
      params = { service_id: @service.id, @review.id, review: { body: "Update body" } }
      patch :update, xhr: true, params: params

      expect(flash[:danger]).to eql("You're not authorized")
    end

    it "should update comment for user" do

      session[:id] = @user.id
      @review = Review.first
      params = { service_id: @service.id, @review.id, review: { body: "Update body" } }
      patch :update, xhr: true, params: params

      @review.reload

      expect(@review.body).to eql("Update body")
    end
  end

  describe "delete comment" do
    it "should deny if user not logged in" do

      @review = Review.first
      params = { service_id: @service.id, id: @review.id }
      delete :destroy, xhr: true, params: params

      expect(flash[:danger]).to eql("You need to login first")
    end

    it "should deny unauthorized user" do

      session[:id] = @invader_zim.id
      @review = Review.first
      params = { service_id: @service.id, id: @review.id  }
      delete :destroy, xhr: true, params: params

      expect(flash[:danger]).to eql("You're not authorized")
    end

    it "should delete review for user" do

      session[:id] = @user.id
      @review = Review.first
      params = { service_id: @service.id, id: @review.id  }
      delete :destroy, xhr: true, params: params

      review = Review.find_by(id: @review.id)

      expect(@user.reviews.count).to eql(3)
      expect(review).to be_nil
    end

    it "should delete review for moderator" do

      session[:id] = @user.id
      @review = Review.first
      params = { service_id: @service.id, id: @review.id }
      delete :destroy, xhr: true, params: params

      review = .find_by(id: @review.id)

      expect(@user.reviews.count).to eql(3)
      expect(review).to be_nil
    end

    it "should delete review for admin" do

      session[:id] = @admin.id
      @review = Review.first
      params = { service_id: @service.id, id: @review.id  }
      delete :destroy, xhr: true, params: params

      review = Review.find_by(id: @review.id)

      expect(@user.reviews.count).to eql(3)
      expect(review).to be_nil
    end
  end



end
