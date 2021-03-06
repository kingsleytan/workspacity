require 'rails_helper'

RSpec.describe Vote, type: :model do
  context "association" do
    it { should belong_to(:user) }
    it { should belong_to(:review) }
  end
end
