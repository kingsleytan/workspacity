require 'rails_helper'

RSpec.describe VotesController, type: :controller do

  before(:all) do

    @admin = create(:user, :admin)
    @user = create(:user)
    @service = create(:service)
    @review = create(:review, :sequenced_body, user_id: @user.id)

  end

  describe "upvote review" do
    it "should require login" do

      params = { review_id: @review.id }
      post :upvote, xhr: true, params: params

      expect(flash[:danger]).to eql("You need to login first")
    end

    it "should create vote if non-existant" do

      session[:id] = @user.id
      params = { review_id: @review.id }

      expect(Vote.all.count).to eql(0)

      post :upvote, xhr: true, params: params

      expect(Vote.all.count).to eql(1)
      expect(Vote.first.user).to eql(@user)
      expect(Vote.first.review).to eql(@review)
      expect(assigns[:vote]).to_not be_nil
    end

    it "should find vote if existant" do

      @vote = @user.votes.create(review_id: @review.id)
      expect(Vote.all.count).to eql(1)

      session[:id] = @user.id
      params = { review_id: @review.id }
      post :upvote, xhr: true, params: params

      expect(Vote.all.count).to eql(1)
      expect(assigns[:vote]).to eql(@vote)
    end

    it "should +1 vote" do

      session[:id] = @user.id
      params = { review_id: @review.id }
      post :upvote, xhr: true, params: params

      expect(assigns[:vote].value).to eql(1)
      expect(Vote.first.value).to eql(1)
    end
  end

  describe "downvote review" do
    it "should require login" do

      params = { review_id: @review.id }
      post :downvote, xhr: true, params: params

      expect(flash[:danger]).to eql("You need to login first")
    end

    it "should create vote if non-existant" do

      session[:id] = @user.id
      params = { review_id: @review.id }

      expect(Vote.all.count).to eql(0)

      post :downvote, xhr: true, params: params

      expect(Vote.all.count).to eql(1)
      expect(Vote.first.user).to eql(@user)
      expect(Vote.first.review).to eql(@review)
      expect(assigns[:vote]).to_not be_nil
    end

    it "should find vote if existant" do

      @vote = @user.votes.create(review_id: @review.id)
      expect(Vote.all.count).to eql(1)

      session[:id] = @user.id
      params = { review_id: @review.id }
      post :downvote, xhr: true, params: params

      expect(Vote.all.count).to eql(1)
      expect(assigns[:vote]).to eql(@vote)
    end

    it "should -1 vote" do

      session[:id] = @user.id
      params = { review_id: @review.id }
      post :downvote, xhr: true, params: params

      expect(assigns[:vote].value).to eql(-1)
      expect(Vote.first.value).to eql(-1)
    end
  end

end
