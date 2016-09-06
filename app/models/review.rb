class Review < ApplicationRecord
  has_many :votes
  belongs_to :service
  belongs_to :user
  # mount_uploader :image, ImageUploader

  validates :body, length: { minimum: 5 }, presence: true
  paginates_per 8

  validate :image_size

  def positive_votes
    self.votes.where(value: 1).count
  end

  def negative_votes
    self.votes.where(value: -1).count
  end
end
