class Property < ApplicationRecord
  has_many :solds
  has_many :auctions
end
