class Package < ApplicationRecord

has_many :reviews
belongs_to :service
belongs_to :user

end
