class User < ApplicationRecord
  # extend FriendlyId
  # friendly_id :username, use: :slugged

  has_secure_password
  has_many :services
  has_many :packages
  has_many :reviews
  has_many :votes
  # mount_uploader :image, ImageUploader

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            # format: { with: VALID_EMAIL_REGEX },
            # presence: true,
            uniqueness: {message: "This email already exist."}

  validates :username,
            presence: true,
            uniqueness: {message: "This username already exist."}

  # validate :image_size

  enum role: [:user, :moderator, :admin]
  # before_save :update_slug

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.username = auth.info.name
        user.email = auth.info.email
        user.oauth_token = auth.credentials.token
        user.password = auth.credentials.token.slice(0,20)
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        user.save!
      end
  end

  # private
  #
  # def update_slug
  #   self.slug = self.username.downcase.gsub(" ", "-") if self.username != nil && self.slug != self.username.downcase.gsub(" ", "-")
  # end

end
