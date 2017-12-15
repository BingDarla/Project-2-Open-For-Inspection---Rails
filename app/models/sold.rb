# == Schema Information
#
# Table name: solds
#
#  id          :integer          not null, primary key
#  sold_date   :date
#  sold_price  :integer
#  property_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Sold < ApplicationRecord
end
