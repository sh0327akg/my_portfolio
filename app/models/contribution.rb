# == Schema Information
#
# Table name: contributions
#
#  id                  :bigint           not null, primary key
#  contribution_number :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  mountain_id         :bigint
#  user_id             :bigint
#
# Indexes
#
#  index_contributions_on_mountain_id  (mountain_id)
#  index_contributions_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (mountain_id => mountains.id)
#  fk_rails_...  (user_id => users.id)
#
class Contribution < ApplicationRecord
  belongs_to :mountain, optional: true
  belongs_to :user, optional: true

  validates :contribution_number, presence: true

  def higher_fuji?
    self.contribution_number > 3776
  end

  def display_contribution_number
    contribution_number ? "積み上げた草は#{contribution_number}草でした！" : "存在しない"
  end

  def display_mountain
    mountain ? "「#{mountain.name}」級の草！" : ""
  end

end
