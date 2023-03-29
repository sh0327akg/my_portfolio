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
  include GraphqlApi

  MINIMUM_CONTRIBUTIONS = 10
  FUJI_HEIGHT = 3776

  belongs_to :mountain, optional: true
  belongs_to :user, optional: true

  validates :contribution_number, presence: true

  def higher_fuji?
    contribution_number > FUJI_HEIGHT
  end

  def build_for_user(account_name)
    # APIに対してクエリを実行し、totalContirubitonsを取得する
    api_result = GraphqlApi.graphql_result(GraphqlApi::TotalContributionsQuery, user: account_name).user

    return unless api_result.present?

    contribution_number = api_result.contributions_collection.contribution_calendar.total_contributions
    # 草の数をセットする
    self.contribution_number = contribution_number
    # 山のデータをセットする
    self.mountain_id = set_mountains(contribution_number) if contribution_number >= MINIMUM_CONTRIBUTIONS
  end

  private

  def set_mountains(contributions)
    grass_number = less_than_fuji(contributions)
    mountain = Mountain.where('elevation <= ?', grass_number).min_by { |m| (m.elevation - grass_number).abs }
    mountain.id
  end

  def less_than_fuji(contributions)
    contributions <= FUJI_HEIGHT ? contributions : contributions - FUJI_HEIGHT
  end
end
