# == Schema Information
#
# Table name: properties
#
#  id            :integer          not null, primary key
#  address       :text
#  landsize      :integer
#  bedrooms      :integer
#  bathrooms     :float
#  parking       :boolean
#  expectedPrice :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Property < ApplicationRecord
end
