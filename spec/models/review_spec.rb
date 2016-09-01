require 'rails_helper'
include ActionDispatch::TestProcess

RSpec.describe Review, type: :model do
  context "assocation" do
    it { should belong_to(:service) }
    it { should belong_to(:user) }
    it { should have_many(:votes) }
  end

  context "body validation" do
    it { should validate_presence_of(:body) }
    it { should validate_length_of(:body).is_at_least(5) }
  end

  context "image size validation" do
    it "should reject image larger than 1mb" do
      comment = create(:review)
      comment.update(image: fixture_file_upload("bigcat.jpg"))

      expect(comment.errors.full_messages[0]).to eql("File size is too big. Please make sure it is 1MB or smaller.")
    end

    it "should allow image smaller than 1mb" do
      comment = create(:review)
      comment.update(image: fixture_file_upload("cat.jpg"))

      expect(comment.image).to be_present
      expect(comment.image.file.size).to be <= 1.megabyte
    end
  end

  context "total votes" do
    it "should give 0 if no votes" do
      review = create(:review)

      expect(review.positive_votes).to eql(0)
      expect(review.negative_votes).to eql(0)
    end

    it "should calculate the correct vote score" do
      review = create(:review)
      user = create(:user)

      10.times.each { |x| user.votes.create(review_id: review.id, value: x % 3 == 0 ? -1 : 1 )}

      expect(review.positive_votes).to eql(6)
      expect(review.negative_votes).to eql(4)
    end
  end
end
