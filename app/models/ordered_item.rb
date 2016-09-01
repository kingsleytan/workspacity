class OrderedItem < ApplicationRecord
  belongs_to :packages
  belongs_to :order
end
