class OrderedItem < ApplicationRecord
  belongs_to :package
  belongs_to :order
end
