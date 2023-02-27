# == Schema Information
#
# Table name: contributions
#
#  id                  :bigint           not null, primary key
#  contribution_number :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  mountain_id         :bigint
#
# Indexes
#
#  index_contributions_on_mountain_id  (mountain_id)
#
# Foreign Keys
#
#  fk_rails_...  (mountain_id => mountains.id)
#
class Contribution < ApplicationRecord
  belongs_to :mountain, optional: true

  validates :contribution_number, presence: true

  def higher_fuji?
    return true if self.contribution_number > 3776
  end
end
