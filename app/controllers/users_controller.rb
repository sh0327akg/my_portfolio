class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show]

  def show
    @user = User.find(params[:id])
    gon.mountains = @user.mountains.distinct
  end
end
