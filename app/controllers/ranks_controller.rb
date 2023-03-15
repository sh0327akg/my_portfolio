class RanksController < ApplicationController
  def rank
    user_contributions = {}
    User.find_each do |user|
      latest_contribution = user.contributions.order(created_at: :desc).first
      user_contributions[user] = latest_contribution if latest_contribution
    end
    @user_contribution_ranks = user_contributions.sort_by { |_key, value| value.contribution_number }.reverse
  end
end
