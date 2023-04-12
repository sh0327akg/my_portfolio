class RanksController < ApplicationController
  def rank
    latest_contributions = User.latest_contributions
    sorted_contributions = latest_contributions.sort_by { |contribution| -contribution.contribution_number }
    @user_contribution_ranks = Kaminari.paginate_array(sorted_contributions).page(params[:page]).per(20)
  end
end
