class UsersController < ApplicationController
  include GraphqlApi
  before_action :require_login

  def show
    @user = User.find(params[:id])
    gon.mountains = @user.mountains.distinct

    if @user == current_user && @user.should_fetch_streak_data?
      streak_data = GraphqlApi.graphql_result(ContributionStreakQuery, user: @user.nickname).user
      @user.update_streak_count(streak_data)
    end
      @streak_count = @user.streak_count
  end

  def contribution_history
    @user = User.find(params[:id])
    @contributions = @user.contribution_history.page(params[:page]).per(25)
  end
end
