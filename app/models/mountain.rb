# == Schema Information
#
# Table name: mountains
#
#  id         :bigint           not null, primary key
#  elevation  :integer
#  kana       :string
#  latitude   :float
#  longitude  :float
#  name       :string
#  prefecture :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_mountains_on_elevation  (elevation)
#
class Mountain < ApplicationRecord
  has_many :contributions
  has_many :users, through: :contributions

  scope :highest, -> { order(elevation: :desc).first }
end
