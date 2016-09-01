class Order < ApplicationRecord
has_many :ordered_items
  has_many :packages, through: :ordered_items
  belongs_to :user


end
