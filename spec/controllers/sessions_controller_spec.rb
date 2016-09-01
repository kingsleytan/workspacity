require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "render new" do
    it "should render new" do

      get :new
      expect(subject).to render_template(:new)
    end
  end

  describe "create session" do
    before(:all) do
      @user = create(:user)
    end

    it "should log in user" do
      params = { user: { username: "Apple", password: "123" } }
      post :create, params: params


      user = User.find_by(email: "user@email.com")
      expect(session[:id]).to eql(user.id)

      expect(subject.send(:current_user)).to eql(@user)
      expect(flash[:success]).to eql("Welcome back #{user.username}")
    end

    it "should show login error" do
      params = { user: { email: "user@email.com", password: "wrongpassword" } }
      post :create, params: params

      current_user = subject.send(:current_user)

      expect(session[:id]).to be_nil
      expect(current_user).to be_nil
      expect(flash[:danger]).to eql("Error logging in")
    end
  end
end
