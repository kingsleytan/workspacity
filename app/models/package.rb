class Package < ApplicationRecord

  has_many :reviews
  belongs_to :service
  belongs_to :user
  has_many :orders, through: :ordered_items
  has_many :ordered_items

  searchkick

end
