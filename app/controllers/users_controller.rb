class UsersController < ApplicationController
  include GraphqlApi
  before_action :require_login

  def show
    @user = User.find(params[:id])
    gon.mountains = @user.mountains.distinct

    update_user_streak_count(@user.nickname) if @user == current_user && should_fetch_streak_data?
    @streak_count = @user.streak_count
  end

  private

  def should_fetch_streak_data?
    current_user.last_streak_updated_at.nil? || current_user.last_streak_updated_at < 1.day.ago
  end

  def update_user_streak_count(account_name)
    streak_data = graphql_result(ContributionStreakQuery, user: account_name).user
    return unless streak_data.present?
    # APIからカレンダーのデータを取得
    contribution_days = streak_data.contributions_collection.contribution_calendar.weeks.flat_map(&:contribution_days)
    streak_count = calculate_streak(contribution_days)
    current_user.update(streak_count: streak_count, last_streak_updated_at: Time.current)
  end

  def calculate_streak(contribution_days)
    current_streak = 0

    contribution_days.reverse_each do |day|
      break if day.contribution_count == 0
      current_streak += 1
    end
    current_streak
  end
end
