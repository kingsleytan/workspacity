require 'rails_helper'
include ActionDispatch::TestProcess

RSpec.describe User, type: :model do
  context "assocation" do
    it { should have_many(:services) }
    it { should have_many(:reviews) }
    it { should have_many(:votes) }
  end

  context "email validation" do

    it do
      should validate_uniqueness_of(:email).
        with_message('This email already exist.')
    end
    it { should allow_value("user@gmail.com").for(:email) }
    it { should_not allow_value("invalidformat").for(:email) }

  end

  context "username validation" do
    it { should validate_presence_of(:username) }

    it do
      should validate_uniqueness_of(:username).
        with_message('This username already exist.')
    end
  end

  context "image size validation" do
    it "should reject image larger than 1mb" do
      user = create(:user)
      user.update(image: fixture_file_upload("bigcat.jpg"))

      expect(user.errors.full_messages[0]).to eql("File size is too big. Please make sure it is 1MB or smaller.")
    end

    it "should allow image smaller than 1mb" do
      user = create(:user)
      user.update(image: fixture_file_upload("cat.jpg"))

      expect(user.image).to be_present
      expect(user.image.file.size).to be <= 1.megabyte
    end
  end

  context "slug callback" do
    it "should set slug" do
      user = create(:user)
      expect(user.slug).to eql(user.username.downcase.gsub(" ", "-"))
    end

    it "should update slug" do
      user = create(:user)
      user.update(username: "updatedname")
      expect(user.slug).to eql("updatedname")
    end
  end
end
