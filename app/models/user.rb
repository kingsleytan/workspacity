class User < ApplicationRecord
  # extend FriendlyId
  # friendly_id :username, use: :slugged

  has_secure_password
  has_many :services
  has_many :packages
  has_many :reviews
  has_many :votes
  has_many :orders
  # mount_uploader :image, ImageUploader

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            format: { with: VALID_EMAIL_REGEX },
            presence: true,
            uniqueness: {message: "This email already exist."}

  validates :username,
            presence: true,
            uniqueness: {message: "This username already exist."}

  # validate :image_size

  enum role: [:user, :moderator, :admin]
  # before_save :update_slug

  private

  def update_slug
    self.slug = self.username.downcase.gsub(" ", "-") if self.username != nil && self.slug != self.username.downcase.gsub(" ", "-")
  end

end
