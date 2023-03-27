# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  last_streak_updated_at :datetime
#  nickname               :string           default(""), not null
#  provider               :string           default(""), not null
#  streak_count           :integer          default(0)
#  uid                    :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_nickname  (nickname) UNIQUE
#
class User < ApplicationRecord
  include GraphqlApi

  has_many :contributions
  has_many :mountains, through: :contributions

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]

    find_or_create_by(provider:, uid:) do |user|
      user.nickname = auth[:info][:nickname]
    end
  end

  def contribution_history
    contributions.order(created_at: :desc)
  end

  def should_fetch_streak_data?
    last_streak_updated_at.nil? || last_streak_updated_at < 1.day.ago
  end

  def fetch_and_update_streak_data
    return unless should_fetch_streak_data?

    streak_data = GraphqlApi.graphql_result(GraphqlApi::ContributionStreakQuery, user: nickname).user
    update_streak_count(streak_data)
  end

  def update_streak_count(streak_data)
    return unless streak_data.present?
    # APIからカレンダーのデータを取得
    contribution_days = streak_data.contributions_collection.contribution_calendar.weeks.flat_map(&:contribution_days)
    streak_count = calculate_streak(contribution_days)
    update(streak_count: streak_count, last_streak_updated_at: Time.current)
  end

  private

  def calculate_streak(contribution_days)
    current_streak = 0

    contribution_days.reverse_each do |day|
      break if day.contribution_count == 0
      current_streak += 1
    end
    current_streak
  end
end
