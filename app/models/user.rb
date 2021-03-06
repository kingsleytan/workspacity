class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  # extend FriendlyId
  # friendly_id :username, use: :slugged

  has_many :services
  has_many :packages
  has_many :reviews
  has_many :votes
  # mount_uploader :image, ImageUploader

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            format: { with: VALID_EMAIL_REGEX },
            presence: true,
            uniqueness: {message: "This email already exist."}

  # validates :username,
  #           presence: true,
  #           uniqueness: {message: "This username already exist."}

  # validate :image_size

  enum role: [:user, :moderator, :admin]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def set_default_email
  end

end
