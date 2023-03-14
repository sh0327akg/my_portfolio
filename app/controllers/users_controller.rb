class UsersController < ApplicationController
  before_action :require_login

  def show
    @user = User.find(params[:id])
    gon.mountains = @user.mountains.distinct
  end
end
