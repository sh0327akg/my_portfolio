class UsersController < ApplicationController
  before_action :require_login

  def index
    @users = User.includes(:contributions).order(contribution_number: :desc)
  end

  def show
    @user = User.find(params[:id])
    gon.mountains = @user.mountains.distinct
  end
end
