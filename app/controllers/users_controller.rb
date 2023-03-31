class UsersController < ApplicationController
  before_action :require_login

  def show
    @user = User.find(params[:id])
    gon.mountains = @user.mountains.distinct
    @next_mountain = @user.contributions.order(created_at: :desc).first.next_mountain

    @user.fetch_and_update_streak_data if @user == current_user
    @streak_count = @user.streak_count
  end

  def contribution_history
    @user = User.find(params[:id])
    @contributions = @user.contribution_history.page(params[:page]).per(25)
  end
end
