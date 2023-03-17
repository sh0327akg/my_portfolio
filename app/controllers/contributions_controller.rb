class ContributionsController < ApplicationController
  include GraphqlApi

  def index
    gon.mountains = Contribution.select(:mountain_id).distinct.map(&:mountain).compact
  end

  def new; end

  def create
    account_name = params[:user_name]
    contribution = if current_user && current_user.nickname == account_name
                     current_user.contributions.build
                   else
                     @contribution = Contribution.new
                   end
    build_contribution_for_user(account_name, contribution)
    if contribution.save
      redirect_to contribution_path(contribution)
    else
      flash.now[:alert] = "ユーザーが見つかりませんでした"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @contribution = Contribution.find(params[:id])
    gon.mountain = @contribution.mountain
  end

  def streak
    if current_user && should_fetch_streak_data?
      update_user_streak_count
    else
      @streak_count = curren_user.streak_count
    end
  end

  private

  def build_contribution_for_user(account_name, contribution)
    # APIに対してクエリを実行し、totalContirubitonsを取得する
    api_result = graphql_result(TotalContributionsQuery, user: account_name).user

    return unless api_result.present?

    contribution_number = api_result.contributions_collection.contribution_calendar.total_contributions
    # 草の数をセットする
    contribution.contribution_number = contribution_number
    # 山のデータをセットする
    contribution.mountain_id = set_mountains(contribution_number) if contribution_number >= 10
  end

  def less_than_fuji(contributions)
    contributions <= 3776 ? contributions : contributions - 3776
  end

  def set_mountains(contributions)
    grass_number = less_than_fuji(contributions)
    mountain = Mountain.where('elevation <= ?', grass_number).min_by { |m| (m.elevation - grass_number).abs }
    mountain.id
  end

  def should_fetch_streak_data?
    current_user.last_streak_updated_at.nil? || current_user.last_streak_updated_at < 1.day.ago
  end

  def update_user_streak_count
    account_name = current_user.nickname
    streak_data = graphql_result(ContributionsStreakQuery, user: account_name).user

    return unless streak_data.present?
    # APIからカレンダーのデータを取得
    contribution_days = streak_data.contributions_collection.contributionCalendar.weeks.flat_map(&:contributionDays)
    streak_count = calculate_streak(contribution_days)
    current_user.update(streak_count: streak_count, last_streak_updated_at: Time.current)
  end

  def calculate_streak(contribution_days)
    streak_count = 0
    current_streak = 0

    contribution_days.reverse_each do |day|
      break if day.contributionCount.positive?
      current_streak += 1
    end

    current_streak
  end
end
