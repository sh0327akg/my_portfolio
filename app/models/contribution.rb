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
    return false unless user_exists?(account_name) && set_contribution_data(account_name)
    # 山のデータをセットする
    self.mountain_id = find_nearest_mountain(contribution_number) if contribution_number >= MINIMUM_CONTRIBUTIONS

    true
  end

  def next_mountain
    current_mountain = self.mountain
    higher_mountains = Mountain.where('elevation > ?', current_mountain.elevation).order(elevation: :asc)
    higher_mountains.first
  end

  private

  def set_contribution_data(account_name)
    # APIに対してクエリを実行し、totalContirubitonsを取得する
    api_result = GraphqlApi.graphql_result(GraphqlApi::TotalContributionsQuery, user: account_name).user
    return false if api_result.nil?
    self.contribution_number = api_result.contributions_collection.contribution_calendar.total_contributions

    true
  end

  def find_nearest_mountain(contributions)
    grass_number = less_than_fuji(contributions)
    nearest_mountains = Mountain.where('elevation <= ?', grass_number).group_by { |m| (m.elevation - grass_number).abs }.min&.last
    nearest_mountains&.sample&.id
  end

  def less_than_fuji(contributions)
    contributions <= FUJI_HEIGHT ? contributions : contributions - FUJI_HEIGHT
  end

  def user_exists?(account_name)
    uri = "https://github.com/#{account_name}"
    response = Net::HTTP.get_response(URI.parse(uri))
    response.code == '200'
  end
end
