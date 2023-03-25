class RanksController < ApplicationController
  def rank
    user_contributions = {}
    User.find_each do |user|
      latest_contribution = user.contributions.order(created_at: :desc).first
      user_contributions[user] = latest_contribution if latest_contribution
    end
    sorted_contributions = user_contributions.sort_by { |_key, value| value.contribution_number }.reverse
    @user_contribution_ranks = Kaminari.paginate_array(sorted_contributions).page(params[:page]).per(20)
  end
end
